Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B338A273D77
	for <sched-ext@lists.linux.dev>; Wed, 22 Jul 2026 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730808; cv=none; b=hFWTB9Si/FC6KiUqkvOeUftc3OCSO9kOT43ccQMxhBTmGkqZCnHT3dyxpgyA2mvzf/fCzo1vjyt0AXIeryMvzpI42Tsy3r5Be0RJIIm6rTSzhqeorbBGvC9pbpidSaKW79PIZ2Ja8z1C0QnDeyEMBii5/s8eEweJ5HzA/LQr+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730808; c=relaxed/simple;
	bh=KWWYZWq3f3S202lOKPos9BEBMJMQ+52hdTniyYecPlk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ImO4ccnHiWrgenVIbZzxD0SLgw5AOGjLQVbJEelU8HquD2LMckbAWm7DrxxM9aZ0sEleKOSfbv38aKGurXNmlxepXigAz6vijmIK5rrPbAeHEMH39GIxujY3KUSGqBYKJezn55D55EZUP67MPubNIId6xvrJ0Squ6oFMsZwQ33k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GnUGXu/V; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GnUGXu/V"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495495ad5ddso37581335e9.3
        for <sched-ext@lists.linux.dev>; Wed, 22 Jul 2026 07:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784730805; x=1785335605; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mjcGCiS9WuUKTpAPW5dETsTCw/akiYA9lgsLsiqyTqI=;
        b=GnUGXu/VeQvVgL+Sszhv+YFUMNlBP1/GMiNtks+1qvJ7yfKatsH4G8ThC88M9YcrW2
         WStxTUw7DL/c3kEQJQEjtg+n5QL8h24NTbCe7sl6oELbWA/wzPh10nFiNGvJtozwnAj+
         SciumZuphWPFK65x9ZGcThO1t0Hy0aHES0OwIFoxNP8S55T8WAIqYqPnjK2oIH7CiqWK
         bctGTm0V8nA3VfGtkKUd8hg1XpSgZhrnXUwrtjob1vkgDxpjxhh0bsly3lYNJTunQU2o
         DB+xWZTEwa0EVS+310xYfkowSDgh2h6vpAayY4vcHKYf4ecbXnjcThEQAbp/962WYtj9
         jJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784730805; x=1785335605;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mjcGCiS9WuUKTpAPW5dETsTCw/akiYA9lgsLsiqyTqI=;
        b=Gc3oGHKlRwE60Hhg5ulMnPMeRJ80/o/ZKs5bjaTgCQHdnyJpGbNXw4fkl3lNlzmW6B
         1TJ+wvlyLl/iqMZhA6k9XDq8cJH7Y2VXx2/SKK5IT1HPFF8GC3m4ufRAEfDunHpiV1NQ
         tVNxY8ccYiIIt40Sp9rEhkbht2ctDaW5Zl7BXYSNwnsHNF6T/z46csatdtr00Kou3DYL
         TdrrGpIprPoDV8+5Aiz3VePEcEafeNFAn+8FgSeg2teL/mCxICr7Kj/aN5eGbvEIGh52
         TIM7n2jvWoP8sAQsaoIb0z0V1jXNZ+MP1fVaNvhEc1uve0URbML15NBQUZOLjyVJOuEm
         lJ7w==
X-Forwarded-Encrypted: i=1; AHgh+RpnduQZam14T6hINU3rzkfge/iRUjF6ke7Q8n1qxilzZY/LzcVC+M+IODE4396UbafIij2kVJD1q0Y=@lists.linux.dev
X-Gm-Message-State: AOJu0YzEzYPhUZgnN2etqw3HXs0UOSvqYmvFxHh8uZMUtc/Icy3ugiRA
	HEOvWkbQ01OCTVbNgyMerlG4I0P8BzIv5CLdxq0+kWH4Sgayt5y1vv8nO/jdwWMFTYlMoSUl/o3
	VSg1BxC2IiV3qhg==
X-Received: from wmgg13.prod.google.com ([2002:a05:600d:d:b0:493:bba5:775a])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ed1:b0:495:4cb8:42b9 with SMTP id 5b1f17b1804b1-4954cb842f7mr224569105e9.4.1784730804594;
 Wed, 22 Jul 2026 07:33:24 -0700 (PDT)
Date: Wed, 22 Jul 2026 14:33:07 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260722143307.2772632-1-jpiecuch@google.com>
Subject: [PATCH sched_ext/for-7.2-fixes] sched_ext: mark waker CPU busy when
 selected in WAKE_SYNC case
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"

SCX's built-in idle CPU tracking is imperfect and can be out-of-sync
with the actual idle state of CPUs, especially immediately after
enabling SCX due to scx_idle_enable() marking all online CPUs idle.

scx_select_cpu_dfl() skips marking the selected CPU as busy if
the selected CPU is the waker CPU in the SCX_WAKE_SYNC case.
If the waker CPU was marked idle by SCX, it will still be marked idle
after CPU selection and potentially even after switching to the wakee.

In the allowed_cpus selftest, this can manifest as the test failing with
the following message in dmesg:

  allowed_cpus.bpf.c:21: CPU 0 should be marked as busy

This patch explicitly marks the waker CPU as busy. With this patch,
the test failure no longer reproduces. There are still some pretty
unlikely races that could make the test fail (e.g. pick_task_idle()
marking the selected CPU idle between selection and validation), but
these can't be fixed easily.

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext/idle.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index 8e8c6201b7df..6f93cc32b650 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -554,8 +554,10 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
 		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
 		    !cpumask_empty(idle_cpumask(waker_node)->cpu)) {
-			if (cpumask_test_cpu(cpu, allowed))
+			if (cpumask_test_cpu(cpu, allowed)) {
+				scx_idle_test_and_clear_cpu(cpu);
 				goto out_unlock;
+			}
 		}
 	}
 
-- 
2.55.0.229.g6434b31f56-goog

