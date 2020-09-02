function d = myatand(x,y)

%%%% find the arc tang in degrees:
d = atand(y./x);

%%%% d should be in limit [0,360]:
d = 180*(y<0&x<0) + 180*(x<0&y>0) + 360*(x>0&y<0) + d;

end
