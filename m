Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9DE2580D7
	for <sched-ext@lists.linux.dev>; Sat, 14 Mar 2026 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773459447; cv=none; b=rapmBaBHksODeHiFAbdTvkf4Grro+slCIOYHbtJygZZ84A8Da3CUSlxcg2tcs7l2kL949wj4xzLmeckx+eV5kmJ9Cw/1hNyEsr2fKmmAwoHFfkk7FG/ABvhPFW5gK7NTCQXkdTiX7L2Deg6Aw30VhtIgwOnFUF+15vDyho2kUV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773459447; c=relaxed/simple;
	bh=mYT1ytQBGsneGBJcgTCmh/Y9rmr5JGFB62OHco4CTwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApiyMiVR43mNYAfJ8QfLN8QFKsLLatQ/0Kd3kuZcV8Q2dSErbm30wWA4l2ZaoVh5dZPYsS6OQEiY2oTqjQ+XirN2jcjBhwACVhIrSx0K2vesnl8kffA9aRZFUitfYf106Znl2Hm4yAysmFCDao3xdEgzZmNG8HVXS5ZMxSEz7aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kwkb2zCQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kwkb2zCQ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-829b2018c94so1691621b3a.0
        for <sched-ext@lists.linux.dev>; Fri, 13 Mar 2026 20:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773459446; x=1774064246; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDy+isb6kQ6zV6MwYJJScFXIDTNgDDI/983X04rBB6w=;
        b=Kwkb2zCQGG1PJ/drjzlaQHyRDARkOy83HyY3SVqyNG0PqFJS9fxPvG5xiC/eGjbCl+
         OPWeWjzymg1Ub90a2NQW+vUBzjOJXXn30S/cMeSf4YCX4a6+ZdVh8uKEpBvuHQFgCfOH
         KFnHNz/TKjRCXM0PqPO7ybKYBHbMHqiyCuaPgqXILH32VVBv8IYYlU+TatJ9TUHJMtRi
         l//6fQYam9Bqe82QIXtpRov/jMjMLNYFePU3Hpg6o+TPdF00sICRhLsj69PmdEESl99+
         XhuUnxLXlXjjbvo/OVQnh/3dgCOwA237YmsYBFvGh4hohLeulyWfP8BaK9PFs0eH45uu
         8r6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773459446; x=1774064246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BDy+isb6kQ6zV6MwYJJScFXIDTNgDDI/983X04rBB6w=;
        b=JNH05HLxmK+xgnShhQ3R0MEr91tNPAqz6IuKYHuZD2ndkS9ro5mc6BzVDxZwOTfE5t
         LkUiQN6eSXXaaBQD8/uMNVeRzJ8fc7x01Rd3uVsXzudUI9EcqHsUut/X2lPQZEopuYef
         f10Xstf5qvZw3M60INOdXDeqshUxSfMeo8B3T0KJikb7SiG5+bzSlela85z+YnVoZoEp
         Rb7QtxPyaWwjTFcHALbXZ4rcD2i2pmJNSmMSzWJKsnIKCKuCz/6OnijjI8N6VMEzZpXB
         bcQMzElPn0y1FapeMNfhW7XSeYI2JaxdnEvAA8nSzV1F8nncAXHE8CgW9D8C4yYVyjlK
         qNng==
X-Gm-Message-State: AOJu0YzytE1Z+oEtsT8iGKpqU4Fs9eQk7W+r5VPjvh29s3dHt0Locnwx
	tmIVg1ZRFaTXxgIQue7HyIS0tIljPg5V2j4e4MsNZ9Vrbsm7Owgu5bOmsMeJGW3e
X-Gm-Gg: ATEYQzz8MVO+DeRj72cflINkLT7jte1vhYsvtpYcoj9BeTFkqQz8k4MNgSr3sHLVXx5
	zu6Qnqn1BwrOa3bngKb/7uc1WthJj+IEUP2eKMzM9C+Ic782lg+u2Ra6dkfW2apOWIvsW+Pm0Db
	PK2OwyrBDkiWb7scT1oRg620iEg7CA41m5RWmhHYt/hjXDpURq5SLKBbL6AJhHRCjKJEkkV2yI8
	TO59+4YD+2mkHMjAfgoiKV+yuR0Uu1/JIY5EEX8WBl7oQgoB4Yw+ECkOe+1r/lr383t47gjT0qB
	Znh1w7onanU9fzHyG1HzxLVY+qjkPOrxVIvD63GLY79pezkfI1o8hUbldnAap3R8pdJigBs5Zsa
	rod0T78j9LWtw8cfxcIAQZTtxhupnEvwv61phjrQOWh+rxyyUdusbaWo+UHNXgy0WWdHjJXWkJE
	7jdwBGEWCvPZBB7Xpgr1SzeTuTLoYRC6SHHviCV3UlGDFuRZyOg+OkrHcHwTixxw==
X-Received: by 2002:a05:6a00:94e1:b0:81b:c2b5:31a with SMTP id d2e1a72fcca58-82a198cb6famr4782785b3a.53.1773459446107;
        Fri, 13 Mar 2026 20:37:26 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:812:f4b6:2aba:4bed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a073ad15asm7045304b3a.64.2026.03.13.20.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 20:37:25 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v4 2/2] sched_ext: Update selftests to drop ops.cpu_acquire/release()
Date: Sat, 14 Mar 2026 11:36:45 +0800
Message-ID: <20260314033708.26483-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260314033708.26483-1-yphbchou0911@gmail.com>
References: <20260314033708.26483-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ops.cpu_acquire/release() are deprecated by commit a3f5d4822253
("sched_ext: Allow scx_bpf_reenqueue_local() to be called from
anywhere") in favor of handling CPU preemption via the sched_switch
tracepoint.

In the maximal selftest, replace the cpu_acquire/release stubs with a
minimal sched_switch TP program. Attach all non-struct_ops programs
(including the new TP) via maximal__attach() after disabling auto-attach
for the maximal_ops struct_ops map, which is managed manually in run().

Apply the same fix to reload_loop, which also uses the maximal skeleton.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/maximal.bpf.c | 15 ++++++---------
 tools/testing/selftests/sched_ext/maximal.c     |  3 +++
 tools/testing/selftests/sched_ext/reload_loop.c |  3 +++
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/testing/selftests/sched_ext/maximal.bpf.c
index 01cf4f3da4e0..5858f64313e9 100644
--- a/tools/testing/selftests/sched_ext/maximal.bpf.c
+++ b/tools/testing/selftests/sched_ext/maximal.bpf.c
@@ -67,13 +67,12 @@ void BPF_STRUCT_OPS(maximal_set_cpumask, struct task_struct *p,
 void BPF_STRUCT_OPS(maximal_update_idle, s32 cpu, bool idle)
 {}
 
-void BPF_STRUCT_OPS(maximal_cpu_acquire, s32 cpu,
-		    struct scx_cpu_acquire_args *args)
-{}
-
-void BPF_STRUCT_OPS(maximal_cpu_release, s32 cpu,
-		    struct scx_cpu_release_args *args)
-{}
+SEC("tp_btf/sched_switch")
+int BPF_PROG(maximal_sched_switch, bool preempt, struct task_struct *prev,
+	     struct task_struct *next, unsigned long prev_state)
+{
+	return 0;
+}
 
 void BPF_STRUCT_OPS(maximal_cpu_online, s32 cpu)
 {}
@@ -150,8 +149,6 @@ struct sched_ext_ops maximal_ops = {
 	.set_weight		= (void *) maximal_set_weight,
 	.set_cpumask		= (void *) maximal_set_cpumask,
 	.update_idle		= (void *) maximal_update_idle,
-	.cpu_acquire		= (void *) maximal_cpu_acquire,
-	.cpu_release		= (void *) maximal_cpu_release,
 	.cpu_online		= (void *) maximal_cpu_online,
 	.cpu_offline		= (void *) maximal_cpu_offline,
 	.init_task		= (void *) maximal_init_task,
diff --git a/tools/testing/selftests/sched_ext/maximal.c b/tools/testing/selftests/sched_ext/maximal.c
index c6be50a9941d..1dc369224670 100644
--- a/tools/testing/selftests/sched_ext/maximal.c
+++ b/tools/testing/selftests/sched_ext/maximal.c
@@ -19,6 +19,9 @@ static enum scx_test_status setup(void **ctx)
 	SCX_ENUM_INIT(skel);
 	SCX_FAIL_IF(maximal__load(skel), "Failed to load skel");
 
+	bpf_map__set_autoattach(skel->maps.maximal_ops, false);
+	SCX_FAIL_IF(maximal__attach(skel), "Failed to attach skel");
+
 	*ctx = skel;
 
 	return SCX_TEST_PASS;
diff --git a/tools/testing/selftests/sched_ext/reload_loop.c b/tools/testing/selftests/sched_ext/reload_loop.c
index 308211d80436..49297b83d748 100644
--- a/tools/testing/selftests/sched_ext/reload_loop.c
+++ b/tools/testing/selftests/sched_ext/reload_loop.c
@@ -23,6 +23,9 @@ static enum scx_test_status setup(void **ctx)
 	SCX_ENUM_INIT(skel);
 	SCX_FAIL_IF(maximal__load(skel), "Failed to load skel");
 
+	bpf_map__set_autoattach(skel->maps.maximal_ops, false);
+	SCX_FAIL_IF(maximal__attach(skel), "Failed to attach skel");
+
 	return SCX_TEST_PASS;
 }
 
-- 
2.48.1

