# Ref: https://xon.sh/tutorial_xontrib.html
# DOCKER

def docker_images():
    """Get docker images.
    """
    return $(docker images).split('\n')[1:-1]



def docker_update():
    """Update docker images.
    """
    for i in docker_images():
        name, tag, id, *_ = i.split()
        if 'molecule_local' in name:
            continue
        docker pull @(f'{name}:{tag}')
        logging.info(f'UPDATED docker image: {name}:{tag} (ID: {id})')


def docker_remove_cruft():
    """Remove docker images with <none> tag.
    """
    for i in docker_images():
      name, tag, id, *_ = i.split()
      if 'none' in tag:
        try:
          docker rmi @(id)
          logging.debug(f'REMOVED docker image: {name}:{tag} (ID: {id})')
        except ValueError as e:
          logging.debug(f'NOT REMOVED docker image: {name}:{tag} (ID: {id}')
