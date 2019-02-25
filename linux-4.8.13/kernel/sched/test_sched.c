/*
A scheduler to test the working of the existing system.
*/
#include <linux/sched.h>
#include <linux/interrupt.h>

#include "sched.h"
/*
 * Adding/removing a task to/from a priority array:
 */

void init_test_rq(struct rt_rq *rt_rq)
{
	struct rt_prio_array *array;
	int i;

	array = &rt_rq->active;
	for (i = 0; i < MAX_RT_PRIO; i++) {
		INIT_LIST_HEAD(array->queue + i);
		__clear_bit(i, array->bitmap);
	}
	/* delimiter for bitsearch: */
	__set_bit(MAX_RT_PRIO, array->bitmap);
		/* We start is dequeued state, because no RT tasks are queued */
	rt_rq->rt_queued = 0;

	rt_rq->rt_time = 0;
	rt_rq->rt_throttled = 0;
	rt_rq->rt_runtime = 0;
	raw_spin_lock_init(&rt_rq->rt_runtime_lock);
}

// #define rt_entity_is_task(rt_se) (1)

// static void enqueue_top_rt_rq(struct rt_rq *rt_rq);
// static void dequeue_top_rt_rq(struct rt_rq *rt_rq);

// static inline int on_rt_rq(struct sched_rt_entity *rt_se)
// {
// 	return rt_se->on_rq;
// }

// static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
// {
// 	return container_of(rt_se, struct task_struct, rt);
// }

// static inline struct rq *rq_of_rt_rq(struct rt_rq *rt_rq)
// {
// 	return container_of(rt_rq, struct rq, rt);
// }

// static inline struct rq *rq_of_rt_se(struct sched_rt_entity *rt_se)
// {
// 	struct task_struct *p = rt_task_of(rt_se);

// 	return task_rq(p);
// }

// static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
// {
// 	struct rq *rq = rq_of_rt_se(rt_se);

// 	return &rq->rt;
// }

// #define for_each_sched_rt_entity(rt_se) \
// 	for (; rt_se; rt_se = NULL)

// static void
// dequeue_top_rt_rq(struct rt_rq *rt_rq)
// {
// 	struct rq *rq = rq_of_rt_rq(rt_rq);

// 	BUG_ON(&rq->rt != rt_rq);

// 	if (!rt_rq->rt_queued)
// 		return;

// 	BUG_ON(!rq->nr_running);

// 	sub_nr_running(rq, rt_rq->rt_nr_running);
// 	rt_rq->rt_queued = 0;
// }

// /*
//  * Change rt_se->run_list location unless SAVE && !MOVE
//  *
//  * assumes ENQUEUE/DEQUEUE flags match
//  */
// static inline bool move_entity(unsigned int flags)
// {
// 	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) == DEQUEUE_SAVE)
// 		return false;

// 	return true;
// }

// static void __dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
// {
// 	struct rt_rq *rt_rq = rt_rq_of_se(rt_se);
// 	struct rt_prio_array *array = &rt_rq->active;

// 	if (move_entity(flags)) {
// 		WARN_ON_ONCE(!rt_se->on_list);
// 		__delist_rt_entity(rt_se, array);
// 	}
// 	rt_se->on_rq = 0;

// 	dec_rt_tasks(rt_se, rt_rq);
// }

// static void __delist_rt_entity(struct sched_rt_entity *rt_se, struct rt_prio_array *array)
// {
// 	list_del_init(&rt_se->run_list);

// 	if (list_empty(array->queue + rt_se_prio(rt_se)))
// 		__clear_bit(rt_se_prio(rt_se), array->bitmap);

// 	rt_se->on_list = 0;
// }

// /*
//  * Because the prio of an upper entry depends on the lower
//  * entries, we must remove entries top - down.
//  */
// static void dequeue_rt_stack(struct sched_rt_entity *rt_se, unsigned int flags)
// {
// 	struct sched_rt_entity *back = NULL;

// 	for_each_sched_rt_entity(rt_se) {
// 		rt_se->back = back;
// 		back = rt_se;
// 	}

// 	dequeue_top_rt_rq(rt_rq_of_se(back));

// 	for (rt_se = back; rt_se; rt_se = rt_se->back) {
// 		if (on_rt_rq(rt_se))
// 			__dequeue_rt_entity(rt_se, flags);
// 	}
// }
static void update_curr_test(struct rq *rq)
{
	struct task_struct *curr = rq->curr;
	struct sched_rt_entity *rt_se = &curr->rt;
	u64 delta_exec;

	if (curr->sched_class != &test_sched_class)
		return;

	delta_exec = rq_clock_task(rq) - curr->se.exec_start;
	if (unlikely((s64)delta_exec <= 0))
		return;

	/* Kick cpufreq (see the comment in linux/cpufreq.h). */
	if (cpu_of(rq) == smp_processor_id())
		cpufreq_trigger_update(rq_clock(rq));

	schedstat_set(curr->se.statistics.exec_max,
		      max(curr->se.statistics.exec_max, delta_exec));

	curr->se.sum_exec_runtime += delta_exec;
	account_group_exec_runtime(curr, delta_exec);

	curr->se.exec_start = rq_clock_task(rq);
	cpuacct_charge(curr, delta_exec);

	sched_rt_avg_update(rq, delta_exec);

	if (!rt_bandwidth_enabled())
		return;

	for_each_sched_rt_entity(rt_se) {
		struct rt_rq *rt_rq = rt_rq_of_se(rt_se);

		if (sched_rt_runtime(rt_rq) != RUNTIME_INF) {
			raw_spin_lock(&rt_rq->rt_runtime_lock);
			rt_rq->rt_time += delta_exec;
			if (sched_rt_runtime_exceeded(rt_rq))
				resched_curr(rq);
			raw_spin_unlock(&rt_rq->rt_runtime_lock);
		}
	}
}

static void
enqueue_test_entity( struct sched_rt_entity *rt_se, unsigned int flags)
{
	struct rq *rq = rq_of_rt_se(rt_se);

	dequeue_rt_stack(rt_se, flags);
	for_each_sched_rt_entity(rt_se)
		__enqueue_rt_entity(rt_se, flags);
	enqueue_top_rt_rq(&rq->rt);
}

static void
enqueue_task_test(struct rq *rq, struct task_struct *p, int flags)
{
	struct sched_rt_entity *rt_se = &p->rt;

	if (flags & ENQUEUE_WAKEUP)
		rt_se->timeout = 0;

	enqueue_test_entity(rt_se, flags);
	if (!task_current(rq, p) && tsk_nr_cpus_allowed(p) > 1)
		enqueue_pushable_task(rq, p);

}

static void dequeue_task_test(struct rq *rq, struct task_struct *p, int flags)
{
	struct sched_rt_entity *rt_se = &p->rt;

	update_curr_test(rq);
	dequeue_rt_entity(rt_se, flags);

	dequeue_pushable_task(rq, p);
}

static void yield_task_test(struct rq *rq){
	requeue_task_rt(rq, rq->curr, 0);
}

static void check_preempt_curr_test(struct rq *rq, struct task_struct *p, int flags)
{
	return;
}

static struct task_struct *
pick_next_task_test(struct rq *rq, struct task_struct *prev, struct pin_cookie cookie)
{
	return pick_next_task_rt(rq, prev, cookie);
}

static void put_prev_task_test(struct rq *rq, struct task_struct *p)
{
	return put_prev_task_rt(rq, p);
}

static int
select_task_rq_test(struct task_struct *p, int cpu, int sd_flag, int flags)
{
	return select_task_rq_rt(p, cpu, sd_flag, flags);
}

static void rq_online_test(struct rq *rq)
{
	rq_online_rt(rq);
}

static void rq_offline_test(struct rq *rq)
{
	rq_offline_rt(rq);
}

static void task_woken_test(struct rq *rq, struct task_struct *p)
{
	task_woken_rt(rq, p);
}

static void switched_from_test(struct rq *rq, struct task_struct *p)
{
	switched_from_rt(rq, p);
}

static void set_curr_task_test(struct rq *rq)
{
	set_curr_task_rt(rq);
}

static void task_tick_test(struct rq *rq, struct task_struct *p, int queued)
{
	task_tick_rt(rq, p, queued);
}

static unsigned int get_rr_interval_test(struct rq *rq, struct task_struct *task)
{
	get_rr_interval_rt(rq, task);
}

static void
prio_changed_test(struct rq *rq, struct task_struct *p, int oldprio)
{
	prio_changed_rt(rq, p, oldprio);
}

static void switched_to_test(struct rq *rq, struct task_struct *p)
{
	switched_to_rt(rq, p);
}

static void update_curr_test(struct rq *rq)
{
	update_curr_rt(rq);
}

const struct sched_class test_sched_class = {
	.next			= &fair_sched_class,
	.enqueue_task		= enqueue_task_test,
	.dequeue_task		= dequeue_task_test,
	.yield_task		= yield_task_test,

	.check_preempt_curr	= check_preempt_curr_test,

	.pick_next_task		= pick_next_task_test,
	.put_prev_task		= put_prev_task_test,

#ifdef CONFIG_SMP
	.select_task_rq		= select_task_rq_test,

	.set_cpus_allowed       = set_cpus_allowed_common,
	.rq_online              = rq_online_test,
	.rq_offline             = rq_offline_test,
	.task_woken		= task_woken_test,
	.switched_from		= switched_from_test,
#endif

	.set_curr_task          = set_curr_task_test,
	.task_tick		= task_tick_test,

	.get_rr_interval	= get_rr_interval_test,

	.prio_changed		= prio_changed_test,
	.switched_to		= switched_to_test,

	.update_curr		= update_curr_test,

}

void __init init_sched_test_class(void)
{
	unsigned int i;

	for_each_possible_cpu(i) {
		zalloc_cpumask_var_node(&per_cpu(local_cpu_mask, i),
					GFP_KERNEL, cpu_to_node(i));
	}
}
