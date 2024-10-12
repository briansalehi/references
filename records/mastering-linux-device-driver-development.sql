create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(11, 'Mastering Linux Device Driver Development', 'book', 1, 14, 'https://subscription.packtpub.com/book/iot-hardware/9781789342048');

call add_block('text', 'txt', 'A resource is said to be shared when accessed by several contenders. When they are exclusive, access must be synchronized so that only the allowed contendeer(s) may own the resource.');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'When access to a resource should be synchronized?');

call add_block('text', 'list', 'Locks, conditional variables');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'How many synchronization mechanisms are available in the kernel?');

call add_block('text', 'txt', 'The kernel performs locking by atomically modifying a variable that holds the current state of the resource, making the shared resource visible to contenders that might access it at the same time..');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'What is the granularity of synchronization operations in the kernel?');

call add_block('text', 'list', 'Spinlocks, mutexes');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'What locking types are available in the kernel?');

call add_block('text', 'list', 'Waiting queues, completion queues');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'What conditional variable types are available in the kernel?');

call add_block('text', 'txt', 'There are situations where it is better to wait for the state of the resource to change; for example, waiting for a list to contain at least one object, or a task to complete.');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'What are the use cases of conditional variables in the kernel?');

call add_block('text', 'txt', 'When it comes to locking, it is up to the hardware to allow synchronizations by means of atomic operations.');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'What does the locking mechanism in the kernel depend on?');

call add_block('text', 'txt', 'Disabling interrupts around the critical code sections.');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'What is a simple workaround for a system to ensure atomicity of synchronization operations?');

call add_block('text', 'txt', 'A spinlock operates by disabling the scheduler on the local CPU that is running the task that called the spinlock''s locking API.');
call add_block('text', 'txt', 'This also means that the task currently running on that CPU cannot be preempted by another task, except for interrupts if they are not disabled.');
call add_block('text', 'txt', 'As a result, spinlocks protect resources that only one CPU can access at a time.');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'How does spinlocks operate?');

call add_block('text', 'txt', '`preempt_count` is the preemption status variable, that if equal to 0, means preemption is enabled. However, if it''s greater than 0, means preemption is disabled.');
call add_block('text', 'txt', 'Disabling preepmtion by `preempt_disable()` consists of incrementing `preempt_count` by one, while `preempt_enable()` decrements `preempt_count` by one, and checks whether the new value is 0, and calls `schedule()` if so. These checkings and modifications should be done atomically.');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'How does preemption toggle in a CPU?');

call add_block('text', 'txt', 'Changing preemption status consists of modifying `preempt_count`, an in case of value 0 a call to `schedule()` is performed. Thus, preemption operations should be done atomically.');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'Why does changing of preemption status depends on atomic operations?');

call add_block('text', 'path', 'include/linux/spinlock_types.h');
call add_block('code', 'c', '#define DEFINE_SPINLOCK(x) spinlock_t x = __SPIN_LOCK_UNLOCKED(x)');
call add_block('code', 'c', 'static DEFINE_SPINLOCK(resource_lock);');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'Create and initialize a spinlock using macro?');

call add_block('text', 'txt', 'For dynamic allocation, you need to embed the spinlock into a bigger structure, allocate memory for this structure, and then call `spin_lock_init()` on the spinlock element.');
call add_block('code', 'c', 'struct bigger_struct
{
    spinlock_t lock;
    unsigned int foo;
};

static struct bigger_struct *foo_alloc_init()
{
    struct bigger_struct *bs;
    bs = kmalloc(sizeof(struct bigger_struct), GFP_KERNEL);
    if (!bs)
    {
        return -ENOMEM;
    }
    spin_lock_init(&bs->lock);
    return bs;
}');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'Dynamically create and initialize a spinlock?');

call add_block('code', 'c', 'void spin_lock(spinlock_t *lock);');
call add_block('code', 'c', 'void spin_unlock(spinlock_t *lock);');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'Lock and unlock a spinlock?');

call add_block('text', 'txt', 'Spinlocks prevent preemptions but not interrupts. There might be cases where a task holds a spinlock in order to prevent a shared resource, and an interrupt handler preempts the task to hold and lock the same spinlock. This leads to a deadlock and a workaround to prevent that is to disable interrupts in addition to preemptions on the local CPU.');
call add_block('code', 'c', 'void spin_lock_irq(spinlock_t *lock);');
call add_block('code', 'c', 'void spin_unlock_irq(spinlock_t *lock);');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'What are the use cases of spin_lock_irq and spin_unlock variations?');

call add_block('text', 'txt', '`spin_unlock_irq()` will enable all interrupts on local CPU, even the interrupts that were already disabled.');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'What are the side effects of disabling and enabling interrupts by spinlocks?');

call add_block('code', 'c', 'spin_lock_irqsave(spinlock_t *lock, unsigned long flags);');
call add_block('code', 'c', 'spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags);');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'What is the safe way of enabling and disabling spinlocks?');

call add_block('text', 'txt', 'Though disabling interrupts may prevent kernel preemption, but nothing prevents the protected section from invoking the scheduler.');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'What can invoke a scheduler in critical section?');

call add_block('text', 'txt', 'A critical section that has locked a spinlock and has disabled interrupts should not sleep, because there would be no way to wake it up.');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'When is the consequence of calling the scheduler in a critical section?');

call add_block('text', 'txt', 'Mutex is similar to a spinlock, except that the task can sleep meanwhile mutex is locked.');
call add_block('text', 'txt', 'A spinlock is a lock held by a CPU, while a mutex is a lock held by a task.');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'What is the difference between a mutex and a spinlock?');

call add_block('text', 'txt', 'A mutex is a simple data structure that embeds a wait queue to put contenders to sleep, and a spinlock that protects access to this wait queue.');
call add_block('code', 'c', 'struct mutex
{
    atomic_long_t owner;
    spinlock_t wait_lock;
#ifdef CONFIG_MUTEX_SPIN_ON_OWNER
    struct optimistic_spin_queue osq;
#endif
    struct list_head wait_list;
};');
call add_block('text', 'txt', 'Owner is the process that owns the lock.');
call add_block('text', 'txt', 'Wait list is the list that in which the mutex''s contenders are put to sleep.');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'What constructs a mutex?');

call add_block('code', 'c', 'static DEFINE_MUTEX(<mutex>);');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'Statically define and initialize a mutex?');

call add_block('text', 'txt', '`__mutex_init()` is the low level function for mutex initialization, but more conveniently `mutex_init()` wrapper macro can be used.');
call add_block('code', 'c', 'struct data_transceiver
{
    struct i2c_client *client;
    u16 reg_conf;
    struct mutex mutex;
};

static int fake_probe(struct i2c_client *client, struct i2c_device_id *id)
{
    data_transceiver *data = /* initialization */;
    mutex_init(&data->mutex);
}');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'Dynamically define and initialize a mutex?');

call add_block('code', 'c', 'void mutex_lock(struct mutex *lock);');
call add_block('code', 'c', 'int mutex_lock_interruptible(struct mutex *lock);');
call add_block('code', 'c', 'int mutex_lock_killable(struct mutex *lock);');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'How many functions exist to acquire a mutex?');

call add_block('text', 'txt', 'Whatever locking function used to lock a mutex, the mutex owner should unlock the mutex with the following function:');
call add_block('code', 'c', 'void mutex_unlock(struct mutex *lock);');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'Unlock a mutex?');

call add_block('code', 'c', 'static bool mutex_is_locked(struct mutex *lock);');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'Check if a mutex is locked?');

call add_block('text', 'txt', '`mutex_lock()` should only be used when we can guarantee that the mutex will not be held for a long time.');
call add_block('text', 'txt', 'Typically, you should use the interruptable variant instead.');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'What mutex locking function is recommended to be used?');

call add_block('text', 'list', '- only one task can hold the mutex at a time
- only the owner can unlock the mutex
- multiple unlocks are not permitted
- recursive locking is not permitted
- a mutex object must be initialized via the API
- a mutex object must not be initialized via memset or copying
- task may not exit with mutex held
- memory areas where held locks reside must not be freed
- held mutexes must not be reinitialized
- mutexes may not be used in hardware or software interrupt
- contexts such as tasklets and timers');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'What are the rules to using mutex in the kernel?');

call add_block('text', 'path', 'include/linux/spinlock.h');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'Where is spinlock defined in the kernel?');

call add_block('text', 'path', 'include/linux/mutex.h');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'Where is mutex defined in the kernel?');

call add_block('text', 'txt', 'When we want to acquire a lock without spinning if we are using a spinlock, or sleeping if we are using a mutex.');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'What are the use cases of try-lock functions?');

call add_block('code', 'c', 'int mutex_trylock(struct mutex *lock);');
call add_block('code', 'c', 'int spin_trylock(spinlock_t *lock);');
call add_block('text', 'txt', 'Both functions return 0 when lock is already locked, and 1 when lock acquired.');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'What are the try-lock functions for spinlock and mutex?');

call add_block('code', 'c', 'static DEFINE_SPINLOCK(lock);

static void do_something(void)
{
    if (!spin_trylock(&lock))
    {
        return;
    }

    /* implementations after lock acquired */

    spin_unlock(&lock);
}');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'Try locking a spinlock without spinning?');

call add_block('code', 'c', 'static DEFINE_MUTEX(lock);

static void do_something(void)
{
    if (!mutex_trylock(&lock))
    {
        return;
    }

    /* implementations after lock acquired */

    mutex_unlock(&lock);
}');
call create_note_with_name('Mastering Linux Device Driver Development', 1, 'Try locking a mutex without sleeping?');

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Mastering Linux Device Driver Development', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Mastering Linux Device Driver Development', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Mastering Linux Device Driver Development', 1, '');

drop procedure add_block;
