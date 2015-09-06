#!/bin/bash
ejabberdctl start
tail -F /var/log/ejabberd/ejabberd.log
