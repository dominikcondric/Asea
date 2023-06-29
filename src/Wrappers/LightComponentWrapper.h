#pragma once
#include "Coa/ECS/Components/LightComponent.h"
#include <QQuickItem>

class LightComponentWrapper {
    Q_GADGET
    Q_PROPERTY(float intensity READ intensity WRITE setIntensity)
    Q_PROPERTY(float spotlightCutoff READ spotlightCutoff WRITE setSpotlightCutoff)
    Q_PROPERTY(bool shadowCaster READ shadowCaster WRITE setShadowCaster)
    Q_PROPERTY(QColor color READ color WRITE setColor)
    Q_PROPERTY(QString type READ type WRITE setType)

public:
    LightComponentWrapper() = default;
    LightComponentWrapper(Coa::LightComponent* lightComponent) : m_lightComponent(lightComponent) {}
    ~LightComponentWrapper() = default;
    float intensity() const { return m_lightComponent->intensity; }
    float spotlightCutoff() const { return m_lightComponent->spotlightCutoff; }
    bool shadowCaster() const { return m_lightComponent->shadowCaster; }

    QColor color() const
    {
        return QColor(
            m_lightComponent->color.x * 255,
            m_lightComponent->color.y * 255,
            m_lightComponent->color.z * 255
        );
    }

    QString type()
    {
        switch (m_lightComponent->type) 
        {
            case Coa::LightComponent::Type::Point:
                return "Point";
                break;
            case Coa::LightComponent::Type::Directional:
                return "Directional";
                break;
            case Coa::LightComponent::Type::Spotlight:
                return "Spotlight";
                break;
        }

        return QString();
    }

    void setColor(const QColor& color)
    {
        m_lightComponent->color.x = color.redF();
        m_lightComponent->color.y = color.greenF();
        m_lightComponent->color.z = color.blueF();
    }

    void setIntensity(float intensity)
    {
        m_lightComponent->intensity = intensity;
    }

    void setSpotlightCutoff(float spotlightCutoff)
    {
        m_lightComponent->spotlightCutoff = spotlightCutoff;
    }

    void setShadowCaster(bool shadowCaster)
    {
        m_lightComponent->shadowCaster = shadowCaster;
    }

    void setType(const QString& type)
    {
        if (type == "Point")
            m_lightComponent->type = Coa::LightComponent::Type::Point;
        if (type == "Directional")
            m_lightComponent->type = Coa::LightComponent::Type::Directional;
        if (type == "Spotlight")
            m_lightComponent->type = Coa::LightComponent::Type::Spotlight;
    }

private:
    Coa::LightComponent* m_lightComponent;
};