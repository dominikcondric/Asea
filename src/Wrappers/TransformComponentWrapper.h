#pragma once
#include "Coa/ECS/Components/TransformComponent.h"
#include <QQuickItem>
#include <QQuaternion>

class TransformComponentWrapper {
    Q_GADGET
    Q_PROPERTY(QVector3D scale READ scale WRITE setScale)
    Q_PROPERTY(QVector3D translation READ translation WRITE setTranslation)
    Q_PROPERTY(QVector3D rotation READ rotation)

public:
    TransformComponentWrapper() = default;
    TransformComponentWrapper(Coa::TransformComponent* transformComponent) : m_transformComponent(transformComponent) {}
    ~TransformComponentWrapper() = default;
    QVector3D translation() const
    {
        return QVector3D(
            m_transformComponent->transformation.getTranslation().x,
            m_transformComponent->transformation.getTranslation().y,
            m_transformComponent->transformation.getTranslation().z
        );
    }

    QVector3D scale() const
    {
        return QVector3D(
            m_transformComponent->transformation.getScale().x,
            m_transformComponent->transformation.getScale().y,
            m_transformComponent->transformation.getScale().z
        );
    }
    
    QVector3D rotation() const
    {
        QQuaternion quaternion(
            m_transformComponent->transformation.getRotationQuat().w,
            m_transformComponent->transformation.getRotationQuat().x,
            m_transformComponent->transformation.getRotationQuat().y,
            m_transformComponent->transformation.getRotationQuat().z
        );
        
        float roll, pitch, yaw;
        quaternion.getEulerAngles(&pitch, &yaw, &roll);
        return QVector3D(
            pitch,
            yaw,
            roll
        );
    }

    void setTranslation(const QVector3D& translation)
    {
        m_transformComponent->transformation.translate(glm::vec3(
            translation.x(),
            translation.y(),
            translation.z()
        ));
    }

    void setScale(const QVector3D& scale) const
    {
        m_transformComponent->transformation.scale(glm::vec3(
            scale.x(),
            scale.y(),
            scale.z()
        ));
    }
    
    Q_INVOKABLE void setRotation(float angle, const QVector3D& axis) const
    {
        m_transformComponent->transformation.rotate(angle, glm::vec3(axis.x(), axis.y(), axis.z()));
    }

private:
    Coa::TransformComponent* m_transformComponent;
};  