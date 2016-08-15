Pkg.add("JSON")

using JSON
a = JSON.parsefile("/home/nbuser/julia_packages.json")
for i in a
  Pkg.add(i)
end

Pkg.checkout("Interact")
