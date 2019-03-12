/*
A scheduler to test the working of the existing system.
*/
#include <linux/sched.h>
#include <linux/interrupt.h>

#include "sched.h"
/*
 * Adding/removing a task to/from a priority array:
 */
static void
enqueue_task_test(struct rq *rq, struct task_struct *p, int flags)
{

}

static void dequeue_task_test(struct rq *rq, struct task_struct *p, int flags)
{

}

static void yield_task_test(struct rq *rq){

}

static void check_preempt_curr_test(struct rq *rq, struct task_struct *p, int flags)
{

}

static struct task_struct *
pick_next_task_test(struct rq *rq, struct task_struct *prev, struct pin_cookie cookie)
{

}

static void put_prev_task_test(struct rq *rq, struct task_struct *p)
{

}

static int
select_task_rq_test(struct task_struct *p, int cpu, int sd_flag, int flags)
{

}

static void rq_online_test(struct rq *rq)
{

}

static void rq_offline_test(struct rq *rq)
{

}

static void task_woken_test(struct rq *rq, struct task_struct *p)
{

}

static void switched_from_test(struct rq *rq, struct task_struct *p)
{

}

static void set_curr_task_test(struct rq *rq)
{

}

static void task_tick_test(struct rq *rq, struct task_struct *p, int queued)
{

}

static unsigned int get_rr_interval_test(struct rq *rq, struct task_struct *task)
{

}

static void
prio_changed_test(struct rq *rq, struct task_struct *p, int oldprio)
{

}

static void switched_to_test(struct rq *rq, struct task_struct *p)
{

}

static void update_curr_test(struct rq *rq)
{

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

}
