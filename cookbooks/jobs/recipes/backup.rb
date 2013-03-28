#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: jobs
# Recipe:: backup
#
# Copyright 2013, Carles Muiños
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


box  = node[:box]
jobs = box['jobs']

jobs['users'].each do |username|
  usr = box['users'][username]

  jobs_dir = "#{usr['home']}/#{jobs['folder']}"
  backup_job_dir = "#{jobs_dir}/backup"

  directory backup_job_dir do
    owner username
    group usr['group']
    mode 00755
  end


  template "#{backup_job_dir}/backup.job" do
    source "/jobs/backup/backup.job.erb"
    owner username
    group usr['group']
    mode 00755
    backup false
    variables(
      :backup_job_path => backup_job_dir
    )
  end


  backup_script = "#{backup_job_dir}/backup-#{box['name']}"
  backup_tasks  = jobs['profiles'][username]['backup']['tasks']

  template backup_script do
    source "/jobs/backup/backup-box_name.erb"
    owner username
    group usr['group']
    mode 00755
    backup false
    variables(
      :backup_job_path => backup_job_dir,
      :box_name        => box['name'],
      :jobs_setup_file => "#{jobs_dir}/setup",
      :backup_tasks    => backup_tasks
    )
  end


  backup_launcher = "#{backup_job_dir}/backup-mgr.desktop"

  template backup_launcher do
    source "/jobs/backup/backup-mgr.desktop.erb"
    owner username
    group usr['group']
    mode 00644
    backup false
    variables(
      :backup_script => backup_script
    )
  end


  launchers_dir = "#{usr['home']}/.local/share/applications"

  directory_tree launchers_dir do
    exclude usr['home']
    owner username
    group usr['group']
    mode 00755
  end

  link "#{launchers_dir}/backup-mgr.desktop" do
    to backup_launcher
    owner username
    group usr['group']
  end


  backup_tasks.each do |task|
    task_drive = task['drive'].split(' ').map(&:downcase).join('_')
    backup_task_dir = "#{backup_job_dir}/#{task_drive}"

    directory backup_task_dir do
      owner username
      group usr['group']
      mode 00755
    end

    template "#{backup_task_dir}/#{task['name']}" do
      source "/jobs/backup/drive/backup-drive.erb"
      owner username
      group usr['group']
      mode 00755
      backup false
      variables(
        :backup_task_dir     => backup_task_dir,
        :backup_task_name    => task['name'],
        :backup_drive        => task['drive'],
        :backup_task_folder  => task['folder'],
        :backup_task_drive   => task_drive,
        :backup_task_targets => task['targets']
      )
    end

    task['targets'].each do |target|
      template "#{backup_task_dir}/#{task['name']}-#{target}" do
        source "/jobs/backup/drive/backup-drive-target.erb"
        owner username
        group usr['group']
        mode 00755
        backup false
        variables(
          :backup_task_dir    => backup_task_dir,
          :backup_task_name   => task['name'],
          :backup_task_drive  => task_drive,
          :backup_task_target => target
        )
      end

      template "#{backup_task_dir}/#{task['name']}-#{target}-excl_patterns.lst" do
        source "/jobs/backup/drive/backup-drive-target-excl_patterns.lst.erb"
        owner username
        group usr['group']
        mode 00644
        backup false
      end

      home_folders = data_bag_item('global', 'home_folders')
      incl_patterns_list = home_folders[box['lang']].map { |folder| "#{folder}/***\n" }.join
      incl_patterns_file = "#{backup_task_dir}/#{task['name']}-#{target}-incl_patterns.lst"

      file incl_patterns_file do
        content incl_patterns_list
        owner username
        group usr['group']
        mode 00644
        backup false
      end
    end
  end
end

support "backup" do
  section "jobs"
end

