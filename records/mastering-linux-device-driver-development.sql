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
call add_block('text', 'txt', 'This also means that the task currently running on that CPU cannot be preempted by another task, except for IRQs if they are not disabled.');
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

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Mastering Linux Device Driver Development', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Mastering Linux Device Driver Development', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Mastering Linux Device Driver Development', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Mastering Linux Device Driver Development', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Mastering Linux Device Driver Development', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Mastering Linux Device Driver Development', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Mastering Linux Device Driver Development', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Mastering Linux Device Driver Development', 1, '');

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
drop temp table temp_blocks;
