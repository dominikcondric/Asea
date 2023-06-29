#pragma once
#include <QQuickItem>
#include "Coa/ECS/Components/CameraComponent.h"
#include "SceneWrapper.h"

class CameraComponentWrapper {
    Q_GADGET
    Q_PROPERTY(QVector3D position READ position)
    Q_PROPERTY(float fov READ fov WRITE setFov)
    Q_PROPERTY(float aspectRatio READ aspectRatio WRITE setAspectRatio)
    Q_PROPERTY(float nearPlane READ nearPlane WRITE setNearPlane)
    Q_PROPERTY(float farPlane READ farPlane WRITE setFarPlane)
    Q_PROPERTY(QVector4D orthographicPlanes READ orthographicPlanes)
    Q_PROPERTY(bool isMain READ isMain)
    Q_PROPERTY(int type READ type WRITE setType)

public:
    CameraComponentWrapper() = default;
    CameraComponentWrapper(Coa::CameraComponent* cameraComponent) : m_cameraComponent(cameraComponent) {}
    ~CameraComponentWrapper() = default;
    int type() const { return (int)m_cameraComponent->camera.getType(); }
    void setType(int type) { m_cameraComponent->camera.setType((Cala::Camera::Type)type); }
    float fov() const { return m_cameraComponent->camera.getProjectionViewingAngle(); }
    void setFov(float fov) { m_cameraComponent->camera.setProjectionViewingAngle(fov); }
    float aspectRatio() const { return m_cameraComponent->camera.getProjectionAspectRatio(); }
    void setAspectRatio(float aspectRatio) { m_cameraComponent->camera.setProjectionAspectRatio(aspectRatio); }
    float nearPlane() const { return m_cameraComponent->camera.getProjectionNearPlane(); }
    void setNearPlane(float nearPlane) { m_cameraComponent->camera.setProjectionNearPlane(nearPlane); }
    float farPlane() const { return m_cameraComponent->camera.getProjectionFarPlane(); }
    void setFarPlane(float farPlane) { m_cameraComponent->camera.setProjectionFarPlane(farPlane); }
    
    QVector4D orthographicPlanes() const
    { 
        auto planes = m_cameraComponent->camera.getOrthographicSidePlanes();
        return QVector4D(
            planes.x,
            planes.y,
            planes.z,
            planes.w
        );
    }

    Q_INVOKABLE void setOrthographicPlane(int index, float value) const
    { 
        auto planes = m_cameraComponent->camera.getOrthographicSidePlanes();
        planes[index] = value;
        m_cameraComponent->camera.setProjectionPlanes(planes.x, planes.y, planes.z, planes.w);
    }


    bool isMain() const { return m_cameraComponent->isMain; }

    Q_INVOKABLE void setMain(SceneWrapper sceneWrapper)
    { 
        for (auto entityID : sceneWrapper.m_scene->getComponentEntityList<Coa::CameraComponent>())
        {
            Coa::CameraComponent& cameraComp = sceneWrapper.m_scene->getComponent<Coa::CameraComponent>(entityID);
            if (cameraComp.isMain)
            {
                cameraComp.isMain = false;
                return;
            }
        }

        m_cameraComponent->isMain = true;
    }

    QVector3D position() const
    {
        return QVector3D(
            m_cameraComponent->camera.getPosition().x,
            m_cameraComponent->camera.getPosition().y,
            m_cameraComponent->camera.getPosition().z
        );
    }

private:
    Coa::CameraComponent* m_cameraComponent;
};