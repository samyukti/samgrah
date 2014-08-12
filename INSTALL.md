## Recommended Configuration

  - Rails 4.1.4
  - Nginx
  - Puma

## Nginx Configuration

    upstream samgrah {
      server unix:///opt/apps/samgrah/run/samgrah.sock;
    }

    server {
      listen 80;
      server_name www.samgrah.com;
      root /opt/apps/samgrah/public;

      location / {
        proxy_pass http://samgrah;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      }

      location ~* ^/static/ {
        expires 1y;
        add_header Cache-Control public;
        add_header Last-Modified "";
        add_header ETag "";
        break;
      }

      location ~* ^/assets/ {
        expires 1y;
        add_header Cache-Control public;
        add_header Last-Modified "";
        add_header ETag "";
        break;
      }
    }

## Running the Application

    cd /opt/apps/samgrah
    bundle exec puma -e production -d -b unix:///opt/apps/samgrah/run/samgrah.sock;
    sudo service nginx restart
