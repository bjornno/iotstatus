FROM bjornno/ubuntu
ADD . /dockerdemo
WORKDIR /dockerdemo
RUN bundle 
CMD ["rackup", "--host", "0.0.0.0"]