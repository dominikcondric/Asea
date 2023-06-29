#pragma once
#include "Coa/ECS/Entity.h"
#include <QQuickItem>

class EntityWrapper {
    Q_GADGET

public:
    EntityWrapper() : m_entity(nullptr, -1) {}
    EntityWrapper(const Coa::Entity& entity) : m_entity(entity) {}
    ~EntityWrapper() = default;
    EntityWrapper(const EntityWrapper& other) : m_entity(other.m_entity) {}
    EntityWrapper& operator=(const EntityWrapper& other) { m_entity = other.m_entity; return *this; }
    EntityWrapper(EntityWrapper&& other) : m_entity(std::move(other.m_entity)) {}
    EntityWrapper& operator=(EntityWrapper&& other) { m_entity = std::move(other.m_entity); return *this; }
    Coa::Entity getEntity() const { return m_entity; }

    Q_INVOKABLE QVariant getComponent(const QString& componentName) const;
    Q_INVOKABLE void addComponent(const QString& componentName);
    Q_INVOKABLE void removeComponent(const QString& componentName);
    Q_INVOKABLE bool hasComponent(const QString& componentName) const;
    Q_INVOKABLE int getDepth() const;

private:
    Coa::Entity m_entity;
};