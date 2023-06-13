import { application } from "./application"

import GetController from "./get_controller"
application.register("get", GetController)

import FlashesController from "./flashes_controller"
application.register("flashes", FlashesController)

import SelectableLiController from "./selectable_li_controller"
application.register("selectableLi", SelectableLiController)
