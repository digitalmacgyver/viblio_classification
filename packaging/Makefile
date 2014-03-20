ROOT ?= /deploy
LVL ?= staging
APP = object_classification

install:
	mkdir -p /mnt/object_classification; chmod oug+rw /mnt/object_classification/
	mkdir -p $(ROOT)/$(LVL)/$(APP).next
	tar zxf classification.tar.gz -C $(ROOT)/$(LVL)/$(APP).next
	-rm -rf $(ROOT)/$(LVL)/$(APP).prev
	-mv $(ROOT)/$(LVL)/$(APP) $(ROOT)/$(LVL)/$(APP).prev
	-mv $(ROOT)/$(LVL)/$(APP).next $(ROOT)/$(LVL)/$(APP)
	(cd $(ROOT)/$(LVL); chown -R www-data:www-data $(APP) )
