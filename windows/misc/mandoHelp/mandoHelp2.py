# -*- coding: utf-8 -*-
"""
Created on Thu Jun 22 16:44:27 2017
@author: sakurai
"""


import numpy as np
import cv2
import sys
import screeninfo

if __name__ == '__main__':
    screen_id = 0
    is_color = False

    # get the size of the screen
    screen = screeninfo.get_monitors()[screen_id]
    width, height = screen.width, screen.height

    # create image
    # imagePath = sys.argv[1].encode().decode("utf-8")
    if len(sys.argv) == 2:
        image = cv2.imdecode(np.fromfile(sys.argv[1], dtype=np.uint8), cv2.IMREAD_UNCHANGED)        
        window_name = 'projector'
        cv2.namedWindow(window_name, cv2.WND_PROP_FULLSCREEN)
        cv2.moveWindow(window_name, screen.x - 1, screen.y - 1)
        cv2.setWindowProperty(window_name, cv2.WND_PROP_FULLSCREEN,
                            cv2.WINDOW_FULLSCREEN)
        cv2.imshow(window_name, image)
        cv2.waitKey()
        cv2.destroyAllWindows()