#include "LoadSkyboxCommand.h"

void LoadSkyboxCommand::execute()
{
    if (!m_singleTexture)
    {
        m_entity.getComponent<Coa::SkyboxComponent>().texture.loadCubemapFromImages(m_images);
    }
    // TODO: singleTexture
}
