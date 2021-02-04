install: luarocks nginx/mime.types lualnclean lualn

lualnclean:
	rm -f lua/upcache*

luarocks:
	luarocks --tree=rocks install upcache 2.1.1
	curl -L https://github.com/openresty/lua-resty-lock/archive/v0.08.tar.gz | \
		tar -C ./rocks/share/lua/5.1/ -x -v -z -f - \
			--wildcards '*/lib/resty/*' --strip-components 2
	curl -L https://github.com/openresty/lua-resty-core/archive/v0.1.21.tar.gz | \
		tar -C ./rocks/share/lua/5.1/ -x -v -z -f - \
			--wildcards '*/lib/resty/*' --wildcards '*/lib/ngx/*' --strip-components 2
	curl -L https://github.com/openresty/lua-resty-lrucache/archive/v0.10.tar.gz | \
		tar -C ./rocks/share/lua/5.1/ -x -v -z -f - \
			--wildcards '*/lib/resty/*' --strip-components 2
	curl -L https://github.com/openresty/lua-resty-redis/archive/v0.29.tar.gz | \
		tar -C ./rocks/share/lua/5.1/ -x -v -z -f - \
			--wildcards '*/lib/resty/*' --strip-components 2

lualn:
	cd rocks/share/lua/5.1/ && ln -sf ../../../../lua/* .

nginx/mime.types:
	cd nginx && ln -sf /etc/nginx/mime.types .

nginx/temp:
	mkdir -p nginx/temp
