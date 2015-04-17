require 'render_anywhere'

class Renderer
  include RenderAnywhere

  def build_html template_path
    html = render :template => template_path,
                  :layout => 'application'
    html
  end
  # Include an additional helper
  # If being used in a rake task, you may need to require the file(s)
  # Ex: require Rails.root.join('app', 'helpers', 'blog_pages_helper')
  def include_helper(helper_name)
    set_render_anywhere_helpers(helper_name)
  end

  # Apply an instance variable to the controller
  # If you need to use instance variables instead of locals, just call this method as many times as you need.
  def set_instance_variable(var, value)
    set_instance_variable(var, value)
  end

  class RenderingController < RenderAnywhere::RenderingController
    # include custom modules here, define accessors, etc. For example:
    attr_accessor :current_user
    helper_method :current_user
  end

  # If you define custom RenderingController, don't forget to override this method
  def rendering_controller
    @rendering_controller ||= self.class.const_get("RenderingController").new
  end
end

namespace 'phonegap' do
  task non_digested: :environment do
    assets = Dir.glob(File.join(Rails.root, 'public/assets/**/*'))
    regex = /(-{1}[a-z0-9]{32}*\.{1}){1}/
    assets.each do |file|
      next if File.directory?(file) || file !~ regex

      source = file.split('/')
      source.push(source.pop.gsub(regex, '.'))

      non_digested = File.join(source)
      FileUtils.cp(file, non_digested)
    end
  end
     
  desc 'Prepare files to move to phonegap directory.'
  task :build, [:template_path, :phonegap_www_path]=> :environment do |t, args|

    phonegap_www_path = args[:phonegap_www_path]

    if phonegap_www_path.nil? || phonegap_www_path == ""
      next
    end

    if phonegap_www_path[phonegap_www_path.length - 1] != "/"
      phonegap_www_path += "/"
    end

    #Rake::Task["phonegap:non_digested"].execute
    css_digest_name = ""
    js_digest_name = ""

    File.open(phonegap_www_path + "index.html", "w") do |file|
      r = Renderer.new
      html = r.build_html(args[:template_path])
      css_digest_name = html[/application-.*\.css/]
      js_digest_name = html[/application-.*\.js/]

      html.gsub! /href=\"\/assets\/application-.*\.css\"/, 'href="css/index.css"'
      html.gsub! /src=\"\/assets\/application-.*\.js\"/, 'src="js/index.js"'
      puts html
      file.puts html
    end
    
    cp Rails.root.join("public", "assets", js_digest_name).to_s, phonegap_www_path + "js/index.js"
    cp Rails.root.join("public", "assets", css_digest_name).to_s, phonegap_www_path + "css/index.css"

    Rake::Task["assets:clean"].execute
  end

end
