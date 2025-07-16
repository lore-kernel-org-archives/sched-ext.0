Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19E5341AA
	for <sched-ext@lists.linux.dev>; Wed, 16 Jul 2025 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669987; cv=none; b=OQxjl7qxnJN3gLLJ4F8xf2CzNK+bpmf27me/wgtWlwzzkJ4vpU4hBlGdxXKFVQYwvbvH8jOjW6jp16Nh2R6P+ILmCeVMaz6lF5iSH8eKn6heKZ3FxfTolKrxEfLdYy31IU4fXx6i37/8qx+jv2whOzjbt8mpq7ZR9QBS80cjTFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669987; c=relaxed/simple;
	bh=VtLZKHWeEQrix0u/ie+VyyTC5fO943Q83nJWFCiDwoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ETSKi7GQt9l0gmmnhEPd37v6fjxczMkicVX8+/pyYC1dfyKvmdnyQ90O/DOJbnZTVUDFd9NTonn72bUvhzW5PpJAbcgqhe/yuCMzY6daquJ3AEFBSYvkrDIKIKtvAfeZNZDHL6/cUj2MmD1smZjPDoYx2pZ7MFyd4DkGBc6nAYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aec46b50f33so37764766b.3
        for <sched-ext@lists.linux.dev>; Wed, 16 Jul 2025 05:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669983; x=1753274783;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nHi/Drr0uAysvpOhqgFMruCENictBdFBEyIV3Omq/E=;
        b=wD4ycmG2/9WcOaJOgxOsSXecSQYDS46esH9QqKPyKWK8c8sKPpWG09VoaYqX4ZzQeJ
         Sp/wAOmxYJUXC5OB9Ccu74H5T2RBfMM4bu3hBXD8QuS1lXy0iSHg66pkFJpoZZFR+9nJ
         2oFMrp3v6ySLXxf41IiqeFrQBJh/q+aJ78Ij+iSe/qA9lBPteRjOmZf2etYx6OWwbWv+
         Y/hTmwvD0rlHFoeMGyE47Lz7VT/YVXulbhPbd1xbXZub9BdyW4qACQwQymvBmt75LIDD
         Mq0Fk/qXYazgk9w6C7ibNMhuuLP65QIBBf0jvyB9kWPq+Mqel+OV80zOiA9nvEFrWjcd
         xV/w==
X-Gm-Message-State: AOJu0YzfFQwt5wT7Ftc/VOzVu33DUO4Ulew9RR2X1ToJbaeTS5nxFdfg
	3op8WBSZxeZEKOeW19YmAVy/ZFfK7V2o0UIq/1kOVHz7DY1mULetBorn
X-Gm-Gg: ASbGncu0DO2NKjzUUQen/p73/Bnxyz0hmSQCRSvD0CPmiUKmpWiiIR1plao4GaO0RvM
	xEtIjfN+kBTzn6gtZU27uqT+N1itGdUMno+TCT1FUsmxBXia0s+BRNEkn9J3hXFOXnfOboNpK+Y
	4w5LrjhU6TuvZyKAEp97kYFQAQRQJZ7qhoI7A556v0uHC4RjZTsWD5lbLx7xyKM6DHypCVTHPcc
	BRabfnUzoJpfV+81A+Bb8xA1CiRKPygnrxEF3g0/Oc7NYYwf+eyrBZm+o4tOjgfkFBtqnfAJE1m
	8C5CquTLLG7B8WDBfgLB0Go0i/WvVVrd36ey0XGjkuUWWh7WEg6z3vbP193fn28dhIl9clcRBwk
	sMQ1dhB2aTlIE
X-Google-Smtp-Source: AGHT+IHGQ4kq/7+AoGST06tjPNkopo5tZZQH4Vq1wEvkzrB7zFCChXgmwb/g3sz6G4TXC7budQyvTQ==
X-Received: by 2002:a17:906:3956:b0:ae4:85e:6207 with SMTP id a640c23a62f3a-ae9ce110d20mr190064266b.50.1752669982940;
        Wed, 16 Jul 2025 05:46:22 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee46cdsm1209083466b.60.2025.07.16.05.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:46:22 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 16 Jul 2025 05:46:15 -0700
Subject: [PATCH] sched/ext: Suppress warning in __this_cpu_write() by
 disabling preemption
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-scx_warning-v1-1-0e814f78eb8c@debian.org>
X-B4-Tracking: v=1; b=H4sIABafd2gC/x3MWwqAIBAF0K0M9ztBe+NWIkJsrPmxUKgg3HvQW
 cB5kTkJZ1h6kfiSLEeEJVMR/O7ixkpWWEKt604PplfZP8vtUpS4qc60jQ9mCKPuURHOxEGef5v
 mUj6kZwukXQAAAA==
X-Change-ID: 20250716-scx_warning-5143cf17f806
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, jake@hillion.co.uk, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1603; i=leitao@debian.org;
 h=from:subject:message-id; bh=VtLZKHWeEQrix0u/ie+VyyTC5fO943Q83nJWFCiDwoM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBod58dZupF7dIoNxfa79oXtv/lhj51fVSyLx/8q
 Uvze7a9VbiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHefHQAKCRA1o5Of/Hh3
 bQ5/D/9zPFs4LKba02f3jKhFIkABvfbU2WfdVlBht/GYm35jp6b/C8cnukMTfHNVelKazFXIVYK
 mgfvlw2tBiP5qGe0kiTOgUlzthcd7vfVwYoMM8HSssObBolpkmFJw4CEFBLThc8UqVNS++yTAVS
 /4pC797s+eol9g/a5guSMg8U5e+URSoEN/K3+HmNipcBoQ5eMbPBIg1BKFw+5Wuu1i6PzJ9JGOs
 YkcpxZgCXhBONsy5fWpBtkpeuqvY5SjKdy9E18MyjAs33TEFC+NQwN5vV6rTutHspL2/K0wTwzc
 l2T7y8+7R3INAHfBKbxeVjK+Cf6tqZ/3Zd/z+tPLEV12ZiazpG6fT4T76iVuaqflahRpapFSGHz
 iyL5dIGK/BUnDM99BoB97rfcRD0HoODDxL6V+tHHKxOOzSi5BlYh/zZC5T91PYndlHHLrIK1KaU
 CY720ax/XWx1i8XZOTj/BuG/dPhamwCIH4A3RCVxk9J89wxyZLwAhUIAiFWTAR84lNNJxP0fuPw
 R3nxhHh2SW3oMm0CbLhtkeVw0akAFPz6GzzyYl1iK0PkY1fiHOgAY+opIKuj1HyCJ0v2wUHYBTI
 Fj/J2z9xe7bu47Hx0TgWSArMzg/l3BNVGZSffGz40CVhH2tmuve3up0FuZK3TtZHoS7sdNjxD/v
 e4koLE/M+p3mlxQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

__this_cpu_write() emits a warning if used with preemption enabled.

Function update_locked_rq() might be called with preemption enabled,
which causes the following warning:

	BUG: using __this_cpu_write() in preemptible [00000000] code: scx_layered_6-9/68770

Disable preemption around the __this_cpu_write() call in
update_locked_rq() to suppress the warning, without affecting behavior.

If preemption triggers a  jump to another CPU during the callback it's
fine, since we would track the rq state on the other CPU with its own
local variable.

Suggested-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: 18853ba782bef ("sched_ext: Track currently locked rq")
Acked-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b498d867ba210..24fcbd7331f73 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1258,7 +1258,14 @@ static inline void update_locked_rq(struct rq *rq)
 	 */
 	if (rq)
 		lockdep_assert_rq_held(rq);
+	/*
+	 * __this_cpu_write() emits a warning when used with preemption enabled.
+	 * While there's no functional issue if the callback runs on another
+	 * CPU, we disable preemption here solely to suppress that warning.
+	 */
+	preempt_disable();
 	__this_cpu_write(locked_rq, rq);
+	preempt_enable();
 }
 
 /*

---
base-commit: 155a3c003e555a7300d156a5252c004c392ec6b0
change-id: 20250716-scx_warning-5143cf17f806

Best regards,
--  
Breno Leitao <leitao@debian.org>

