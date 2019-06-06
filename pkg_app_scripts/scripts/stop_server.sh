#!/usr/bin/env bash
# 关闭所有的算法服务

ps -ef | grep XMLRPC_Server | grep -v grep | cut -c 9-15 | xargs kill -s 15
ps -ef | grep XMLRPC_Server_NK | grep -v grep | cut -c 9-15 | xargs kill -s 15
