#include <iostream>
#include <string_view>

class NotifierInterface
{
public:
    virtual ~NotifierInterface() {}
    virtual void send(std::string_view const message) const = 0;
};

class EventNotifier: public NotifierInterface
{
public:
    void send(std::string_view const message) const override { std::cout << message; }
};

class Notifier: public NotifierInterface
{
public:
    Notifier() = delete;
    explicit Notifier(NotifierInterface const& base) : notifier{base} {}
    void send(std::string_view const message) const override { notifier.send(message); }

private:
    NotifierInterface const& notifier;
};

class EncryptedNotifier: public Notifier
{
public:
    EncryptedNotifier() = delete;
    explicit EncryptedNotifier(NotifierInterface const& base): Notifier{base} {}
    void send(std::string_view const message) const override { std::cout << "encrypted<<<"; Notifier::send(message); std::cout << ">>>\n"; }
};

int main()
{
    EventNotifier notifier;
    EncryptedNotifier secure_notifier(notifier);
    notifier.send("notification\n");
    secure_notifier.send("notification");
}
