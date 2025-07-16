Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061EA2F6F91
	for <sched-ext@lists.linux.dev>; Wed, 16 Jul 2025 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687545; cv=none; b=mEefazEbm7B7rKEigrzsgDplCgyxOgajZjUih5Sez8idQ279tU88/JV3lhRQsWD7LW9zv/FWhQWJEakvwodBb3S8x14gMmFeCwlwIpJOxcZ+HAxZpX63eg5ZyZJyoaGFqd4EQcRls8wklxO6PgzH1Ld8bAtbq0jN12QvVcWvUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687545; c=relaxed/simple;
	bh=PmUnS3XfIuti54yGZQp7QyQC26QQ4YmoruNcqJ0/SnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T72YD0ED9VUCmvHMegEXv5+xybHhH2AQsRALGZB8MqLHcMVTxX0j415Z+uj0HUl3DM260pWpNj7PxyATf4b1OcPEnfQ4XKRZwxC3EHAAZahIcstUg86/2oHn28a0zhKwvn7Mc8NkC35L05KGQxvEvD99OgTaKQbl7gOUAI/4xGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso223938566b.0
        for <sched-ext@lists.linux.dev>; Wed, 16 Jul 2025 10:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752687542; x=1753292342;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZeHIIJrtHTOzikZj7FWfivha83sARqGu4O+rj9BWfBY=;
        b=HQrmK1UCddHzhRxGM9yYPfwIJO1OEh7vK53+k7NcsJe9uRdr/IX2fXHfUX+S6hHaSI
         nMKd/RnPpQBPsdn5fleeJ8sNXhyFkIzrbknySTCJ/fk7bkUb3l+jzn8w70ZTZbzls7JG
         vuQuXyPkmiYuEkcwCPRRoryMC0DpudW2SOfoggCK/7zKGouKFLuXgJ02st3/nQm1B4BB
         tWatVQ5d6Q4cKa8TVP6HAIFUm85SxZURXe+75J1gN5lJXhHqbEczxVFjNCdVLXiuEAgK
         Vjzh/xWs1RXlqTJ6LRdfmjl31Xrwg0/KSgrOi4L1SivtqiDlQa5LUfnIvIP6QLqnT+qv
         +dcA==
X-Gm-Message-State: AOJu0Yx0nLtPZy7NRl0ksv9IXHogd5i0mjXXFaO2oZV4GHt9Na1ocPEG
	4octOJ3FhLTBJr+WDGZ6xfoe+6Qu8Xtxi2tic4hu70Z6DHjgPBDdq+At
X-Gm-Gg: ASbGncsLg0EDK6jfTlg/2CXQnDd+cJn7jLHmOYiDyov6nyxFzOZGrcxBagiaRWjBIXT
	DZRh2BO6Z4Qp65IIwnqmp/iXyKWwOT9fv5CEdy/YGCoF4z5+rQ9sboT+UH/Bb9mm35eL3ZFJUdi
	GOazEmhg/ksVe2L/zUvt+zwKUVdFWyv6dRDcyuCX6gcA0TE9MdnR5Q5rn5G0d+50osM1xVuV9Fk
	BzIU5TH8HvaRf7OaPdHpe+haQTc//9gLnOIwtz360/VAIVsoDcknGtfOT8u3pz1d1yCECj09Nja
	G1SQrcVVkighcOaSkxJkjrYIFhxdv7bxz1q474hg+2Q2c7WnauQNLNuPWuq0ec5xe9CORDI1Lmj
	xRa4R1HG+qRKk
X-Google-Smtp-Source: AGHT+IGyws8+mUlkwyFvTNNqyC0X7TNkDmKU9AK0NrdsL0VxWveK1EnbpQKQXuYUz2ogpL2MZV9KLw==
X-Received: by 2002:a17:907:da4:b0:ae3:a71b:1543 with SMTP id a640c23a62f3a-aec4ddb755emr24490266b.2.1752687542186;
        Wed, 16 Jul 2025 10:39:02 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82921bdsm1220626466b.110.2025.07.16.10.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 10:39:01 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 16 Jul 2025 10:38:48 -0700
Subject: [PATCH v2] sched/ext: Prevent update_locked_rq() calls with NULL
 rq
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-scx_warning-v2-1-1d015b2d8efa@debian.org>
X-B4-Tracking: v=1; b=H4sIAKfjd2gC/23MsQ6DIBAA0F8hN0PDWRXC1P9oTKN46C3QQGNtD
 P/e1LnrG94BhTJTAScOyLRx4RTBiUYK8OsYF1I8gxPQ6KbTBntV/P54jzlyXFSH7dUHNMHqHqS
 AZ6bA+7ndBylg5fJK+XPmG/70/7OhQqXJYhuMpcn620wTj/GS8gJDrfULXt+aDKcAAAA=
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
 jake@hillion.co.uk, kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2371; i=leitao@debian.org;
 h=from:subject:message-id; bh=PmUnS3XfIuti54yGZQp7QyQC26QQ4YmoruNcqJ0/SnI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBod+O0HfxjgDEv8Z2p8cMZ+hVsbGfA87i8d3pza
 J3mDtr0sgeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHfjtAAKCRA1o5Of/Hh3
 bfIZD/9YIeDKetG5dqg1+gPnk5tN4b473yxLd69N5UTIH5f1meoDAOIx/mRlLpnWtcBf8SAAwpX
 rRAK1FhF1bnYcRGS0+pVCR+NDNVObgdwrj5u7aUzcFKLsymnwho+udvRnFhKh8VinQE9aOryW9V
 FsEvrtcUkFbLzQGSebXmkaFHmoO2aJ8Ara6yFoZv0iklLaoh1gmoOEn2wIYmD58saT7VS4wFlSK
 sAAQjyaribNMsPbguI/ZlZwUW9GoFlDQ1BU82WOBWCYRN76zFx3B4/qIl7s3PnJ0ZSn1lhplfYB
 tCYN2d8xgp13y/32hf3q5DmGCO0cxyy6clI3/y+CETzOtD5BjgVoRmkfxYNcgn35pAVXw1lisnt
 eQLPtynmu/eYQLLPfZyZw+2csOsBi1+cvcXl7yAa52DkZ7VLsVtAdvabQOMH+tqaCVmWWkVvyac
 TnW7y17uONHHby0zXWdYvKnIm5qrfdEm/KrKwfULSgIs9X5/nb7GAqWEgwSQj9oaNT2HmdlvBU6
 SxcKVemYhfqE2yhOuuFOZf1NLYlQGL5goHkZUV6aOSg97CVSx4QHUdkCzIR50vt9VCCpz7fkOeT
 +xPCi7KSwhf9q9BWgKPd7JcEy7ecUlz19DlJWOHFvzdp6/u0KA2oDMa1ujpMKQyyMpFSuLaYTdX
 uI5C13wS1Wbdvtg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Avoid invoking update_locked_rq() when the runqueue (rq) pointer is NULL
in the SCX_CALL_OP and SCX_CALL_OP_RET macros.

Previously, calling update_locked_rq(NULL) with preemption enabled could
trigger the following warning:

    BUG: using __this_cpu_write() in preemptible [00000000]

This happens because __this_cpu_write() is unsafe to use in preemptible
context.

Ensure that update_locked_rq() is only called when rq is non-NULL,
preventing calling __this_cpu_write() on preemptible context.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Fixes: 18853ba782bef ("sched_ext: Track currently locked rq")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Avoid calling update_locked_rq() completely on preemptible mode (Peter Zijlstra)
- Link to v1: https://lore.kernel.org/r/20250716-scx_warning-v1-1-0e814f78eb8c@debian.org
---
 kernel/sched/ext.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b498d867ba210..7dd5cbcb7a069 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1272,7 +1272,8 @@ static inline struct rq *scx_locked_rq(void)
 
 #define SCX_CALL_OP(sch, mask, op, rq, args...)					\
 do {										\
-	update_locked_rq(rq);							\
+	if (rq)									\
+		update_locked_rq(rq);						\
 	if (mask) {								\
 		scx_kf_allow(mask);						\
 		(sch)->ops.op(args);						\
@@ -1280,14 +1281,16 @@ do {										\
 	} else {								\
 		(sch)->ops.op(args);						\
 	}									\
-	update_locked_rq(NULL);							\
+	if (rq)									\
+		update_locked_rq(NULL);						\
 } while (0)
 
 #define SCX_CALL_OP_RET(sch, mask, op, rq, args...)				\
 ({										\
 	__typeof__((sch)->ops.op(args)) __ret;					\
 										\
-	update_locked_rq(rq);							\
+	if (rq)									\
+		update_locked_rq(rq);						\
 	if (mask) {								\
 		scx_kf_allow(mask);						\
 		__ret = (sch)->ops.op(args);					\
@@ -1295,7 +1298,8 @@ do {										\
 	} else {								\
 		__ret = (sch)->ops.op(args);					\
 	}									\
-	update_locked_rq(NULL);							\
+	if (rq)									\
+		update_locked_rq(NULL);						\
 	__ret;									\
 })
 

---
base-commit: 155a3c003e555a7300d156a5252c004c392ec6b0
change-id: 20250716-scx_warning-5143cf17f806

Best regards,
--  
Breno Leitao <leitao@debian.org>

