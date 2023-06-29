#include "EntityWrapper.h"
#include "ColorComponentWrapper.h"
#include "TagComponentWrapper.h"
#include "TransformComponentWrapper.h"
#include "LightComponentWrapper.h"
#include "TextureComponentWrapper.h"
#include "MeshComponentWrapper.h"
#include "SkyboxComponentWrapper.h"
#include "CameraComponentWrapper.h"
#include "ScriptComponentWrapper.h"

bool EntityWrapper::hasComponent(const QString& componentName) const
{
    if (componentName == "MeshComponent") 
        return m_entity.hasComponent<Coa::MeshComponent>();
    else if (componentName == "ColorComponent")
        return m_entity.hasComponent<Coa::ColorComponent>();
    else if (componentName == "CameraComponent") 
        return m_entity.hasComponent<Coa::CameraComponent>();
    else if (componentName == "LightComponent")
        return m_entity.hasComponent<Coa::LightComponent>();
    else if (componentName == "TextureComponent") 
        return m_entity.hasComponent<Coa::TextureComponent>();
    else if (componentName == "SkyboxComponent")
        return m_entity.hasComponent<Coa::SkyboxComponent>();
    else if (componentName == "TagComponent") 
        return m_entity.hasComponent<Coa::TagComponent>();
    else if (componentName == "TransformComponent")
        return m_entity.hasComponent<Coa::TransformComponent>();
    else if (componentName == "ScriptComponent")
        return m_entity.hasComponent<Coa::ScriptComponent>();

    return false;
}

int EntityWrapper::getDepth() const
{
    int depth = 0;
    Coa::Entity entity = m_entity;
    while (entity.getParent().getEntityID() != -1)
    {
        depth++;
        entity = entity.getParent();
    }

    return depth;
}

QVariant EntityWrapper::getComponent(const QString &componentName) const
{
    if (componentName == "MeshComponent") 
        return QVariant::fromValue<MeshComponentWrapper>(MeshComponentWrapper(&m_entity.getComponent<Coa::MeshComponent>()));
    else if (componentName == "ColorComponent")
        return QVariant::fromValue<ColorComponentWrapper>(ColorComponentWrapper(&m_entity.getComponent<Coa::ColorComponent>()));
    else if (componentName == "CameraComponent") 
        return QVariant::fromValue<CameraComponentWrapper>(CameraComponentWrapper(&m_entity.getComponent<Coa::CameraComponent>()));
    else if (componentName == "LightComponent")
        return QVariant::fromValue<LightComponentWrapper>(LightComponentWrapper(&m_entity.getComponent<Coa::LightComponent>()));
    else if (componentName == "TextureComponent") 
        return QVariant::fromValue<TextureComponentWrapper>(TextureComponentWrapper(&m_entity.getComponent<Coa::TextureComponent>()));
    else if (componentName == "SkyboxComponent")
        return QVariant::fromValue<SkyboxComponentWrapper>(SkyboxComponentWrapper(&m_entity.getComponent<Coa::SkyboxComponent>()));
    else if (componentName == "TagComponent") 
        return QVariant::fromValue<TagComponentWrapper>(TagComponentWrapper(&m_entity.getComponent<Coa::TagComponent>()));
    else if (componentName == "TransformComponent")
        return QVariant::fromValue<TransformComponentWrapper>(TransformComponentWrapper(&m_entity.getComponent<Coa::TransformComponent>()));
    else if (componentName == "ScriptComponent")
        return QVariant::fromValue<ScriptComponentWrapper>(ScriptComponentWrapper(&m_entity.getComponent<Coa::ScriptComponent>()));

    return QVariant();
}

void EntityWrapper::addComponent(const QString &componentName)
{
    if (componentName == "MeshComponent") 
        m_entity.addComponent<Coa::MeshComponent>();
    else if (componentName == "ColorComponent")
        m_entity.addComponent<Coa::ColorComponent>(glm::vec4(1.f));
    else if (componentName == "CameraComponent") 
        m_entity.addComponent<Coa::CameraComponent>(Cala::Camera::Type::Perspective);
    else if (componentName == "LightComponent")
        m_entity.addComponent<Coa::LightComponent>();
    else if (componentName == "TextureComponent") 
        m_entity.addComponent<Coa::TextureComponent>();
    else if (componentName == "SkyboxComponent")
        m_entity.addComponent<Coa::SkyboxComponent>();
    else if (componentName == "ScriptComponent")
        m_entity.addComponent<Coa::ScriptComponent>();
}

void EntityWrapper::removeComponent(const QString &componentName)
{
    if (componentName == "MeshComponent") 
        m_entity.removeComponent<Coa::MeshComponent>();
    else if (componentName == "ColorComponent")
        m_entity.removeComponent<Coa::ColorComponent>();
    else if (componentName == "CameraComponent") 
        m_entity.removeComponent<Coa::CameraComponent>();
    else if (componentName == "LightComponent")
        m_entity.removeComponent<Coa::LightComponent>();
    else if (componentName == "TextureComponent") 
        m_entity.removeComponent<Coa::TextureComponent>();
    else if (componentName == "SkyboxComponent")
        m_entity.removeComponent<Coa::SkyboxComponent>();
    else if (componentName == "ScriptComponent")
        m_entity.removeComponent<Coa::ScriptComponent>();
}