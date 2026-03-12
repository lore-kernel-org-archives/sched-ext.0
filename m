Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3713BE650
	for <sched-ext@lists.linux.dev>; Thu, 12 Mar 2026 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327943; cv=none; b=U7qr7vYaiVf9U13KMYX7vgL4/Y44cE3DAjWPg82rIwAXuSbMlzwFBAiEkIq227cFV38thGyK/oy2nh6QHyFn1EV1U/EzDmdbknaDYyLcEri2LpxjBkvruawMH+dd5O1Ci6lqruvlTCTuIq72vK4mYOwpxKpulIxiWjvMKgJ4wSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327943; c=relaxed/simple;
	bh=LHlCK8WX2SxUwu0IBm7h+sLVoNJDi8rAGsY/Rwlju2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQAD0hQBeQYuMhAhwUCLRSGuU6aAllG3hBarfubKjLaGelTILc6by4iwTSThSdkbULRtnkOkvJufEeiIPJxW1JF0Gda3rVvJo/wTEI4stslcNA7jX6ynKVTNW9a+p74iXDhhEwmRGN2nmkmwuA31fgL9l3oJ7K0XJuhpuWEaz4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=QQs5lVgO; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="QQs5lVgO"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d738fe814cso940702a34.3
        for <sched-ext@lists.linux.dev>; Thu, 12 Mar 2026 08:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327941; x=1773932741; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVRHq7jWveTIXgOH1q2N9YJBNsnY5HcmT1rYL5VJ2Fo=;
        b=QQs5lVgOpaTqqduIK9R+5KQYcNtBnOoXtcAIDyIhnuVtI38tMNctgNYU4B9fQ2SHsG
         pVJsjxj7dXxI7pqjN3gVGOataA/s+bzXlImuE3EMaoV9XUd6rgyGOpjWdS6Le33e/pKO
         AgKlLBTJVsQIh8f21JHZz98bCBBukARF7NLNwnrnLOtb00z9y9IEmzm0fgsQQFy14cN3
         wIwXtuhnpAlpDXYk4jGJGHXpCGNQRZR2atAWAeIiYY7BcNV214J5K5Bw+Xp75q4j0/vg
         kUu78V8YaE+g11pJ/y06MdujJiI2sqZ9mVu4tPo1uBM76EWqVoYO/dMHpiajDdTUX1aA
         0RlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327941; x=1773932741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KVRHq7jWveTIXgOH1q2N9YJBNsnY5HcmT1rYL5VJ2Fo=;
        b=cuRfDsym4Sa6+oDdPqkBjgFuSqbcF1vLm5uJo0Dh2ETpcXc/+f/kvp2Zgl43eGhAhp
         q85lsDsY63CazXUHcEW127fY3Rb/VOD2442s55/MLMDqIoC8IjuwoTNF+W/hImTswrOF
         5W5SRuMD3BZGvfYZE3LZiLwSsdd4gRtBINl7ne9CnyaDCpQHKsiKEeUaaI/07SIxTjyB
         /X9ujINzZfxzTZzWEpqXDuyUiVRrp4zkK6HNoXdiE/OH6tadWbiZNYT7KCJea5YTBijZ
         kSFuK0ANGSSbkAtHlgRohhrL66/Q5nNNC5CpJHARORr/08bebLD6ZzXGou8TrJXRYbf0
         rprw==
X-Forwarded-Encrypted: i=1; AJvYcCV/nt8EAFyIlsy/XAYI9Wrc5MZciTUcGh71a5eYDSD8oobqWXzrr5Hm0pVkX4C4vwhscidsWqyNMl4=@lists.linux.dev
X-Gm-Message-State: AOJu0YzTd+Gy32OYi2ZuMHLb+G3+vPahs+spTGu+4WHsAp70bYSBrLVG
	RnlB4O639BiGqgWD8fTmXkUkDKvGYk8v61BuL+rKIVxgyEioN488MWDL7I6e0WxPiRQ=
X-Gm-Gg: ATEYQzwhcqymwDTtQgPONE32Iwu9kBWuxteN5GCvKlTv3i4CYiP9pJOwTmd0zeK9xNj
	c+UFwUplA3vs1PH7npD2GUnZvib3aCAjQLQN5gSXGaSB9TPRPBSIW8IZ8wicnShT5pgSAlMLAaO
	bm2jsAgxus89POmnFEfw350y3u8ppq/gFBwkXD+wiiwFIKAOerKoh58To0hJ6IK0xWayVfFtb2n
	zJCr55q1p9M0xPYiAB83JMLGB8rS5lNNAU1jEl84f+vcRFAV4RD58FX7+Wlq7RgfQhqNHJjMfvk
	SrDCzJy2So8nRHdHFsH422g47wkycx/O+Oa7phaNeBtxiNpKwqQ/9spK4BYFSupbZxzAtB/Aoz7
	uFWgjgroEB53PvJ68s/NBVx0gJ4Y5HwNTLIp6weQsgPinMAs5pfTfohDtEe9SMZlR1+RkjXkO9K
	ehQInXE3F7M0NbNgMTFjnU/G+aPlF+4ucHO0mw/eEArelPVgty8A3DtnFf5L5UXVEnXA==
X-Received: by 2002:a05:6830:6d09:b0:7d7:496f:c001 with SMTP id 46e09a7af769-7d76a7d8c0amr3733806a34.29.1773327941086;
        Thu, 12 Mar 2026 08:05:41 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:05:40 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rik van Riel <riel@surriel.com>,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 02/15] kernel: Use trace_invoke_##name() at guarded tracepoint call sites
Date: Thu, 12 Mar 2026 11:04:57 -0400
Message-ID: <20260312150523.2054552-3-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_invoke_foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_invoke_foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 kernel/irq_work.c  | 2 +-
 kernel/sched/ext.c | 2 +-
 kernel/smp.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 73f7e1fd4ab4d..74e71b6434841 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -79,7 +79,7 @@ void __weak arch_irq_work_raise(void)
 static __always_inline void irq_work_raise(struct irq_work *work)
 {
 	if (trace_ipi_send_cpu_enabled() && arch_irq_work_has_interrupt())
-		trace_ipi_send_cpu(smp_processor_id(), _RET_IP_, work->func);
+		trace_invoke_ipi_send_cpu(smp_processor_id(), _RET_IP_, work->func);
 
 	arch_irq_work_raise();
 }
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1594987d637b0..93b03d5a8d5b8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4494,7 +4494,7 @@ static __printf(2, 3) void dump_line(struct seq_buf *s, const char *fmt, ...)
 		vscnprintf(line_buf, sizeof(line_buf), fmt, args);
 		va_end(args);
 
-		trace_sched_ext_dump(line_buf);
+		trace_invoke_sched_ext_dump(line_buf);
 	}
 #endif
 	/* @s may be zero sized and seq_buf triggers WARN if so */
diff --git a/kernel/smp.c b/kernel/smp.c
index f349960f79cad..da779fd78ffe7 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -394,7 +394,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
 		func = CSD_TYPE(csd) == CSD_TYPE_TTWU ?
 			sched_ttwu_pending : csd->func;
 
-		trace_csd_queue_cpu(cpu, _RET_IP_, func, csd);
+		trace_invoke_csd_queue_cpu(cpu, _RET_IP_, func, csd);
 	}
 
 	/*
-- 
2.53.0

