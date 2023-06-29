#pragma once
#include "Coa/ECS/Entity.h"

class Command {
public:
    Command(const Coa::Entity& entity) : m_entity(entity) {}
    ~Command() = default;
    virtual void execute() = 0;

protected:
    Coa::Entity m_entity;
};