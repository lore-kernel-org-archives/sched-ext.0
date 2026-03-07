Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BAB301016
	for <sched-ext@lists.linux.dev>; Sat,  7 Mar 2026 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772904397; cv=none; b=oR6EyDzVhj/9lyKVAeW4d3RDJLRtA/rj4TCN1lDvxmYCc45iZlnd0mG4jMNlB1FlC+3DsGInIv1TZHCrV0piGJngwFFX7lnPRV2gg7y6wvCEU4nVvL1tEwl/nPIoeiHAiXmdDyBqEtZc7cYLU2W0yYo/1h6GT7P6IlPIfQWd1H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772904397; c=relaxed/simple;
	bh=lYHaC7nvONMB59XFg9Xne5dm5iBDhFh8hNSf1Vos4Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ti3ymMnIX5x7BI/WJsrk94O/C46kLfnmutjFKcwrLrHmWNsEQsYFBeHBh2DJg8xb/YQjGSYMse/dH4Obap+V7HxMLZzG5ZGZGpx7ydcuYM/cICdtxWt7It3zHnJRcHM4yhFpwvY/HdzZFztyKAKFf0ozF8x0IQyXFH6WV6mAiss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTQO4F8q; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTQO4F8q"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ab077e3f32so45517305ad.3
        for <sched-ext@lists.linux.dev>; Sat, 07 Mar 2026 09:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772904395; x=1773509195; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9DyNcsAMM48Ztv0pJ1eI57h9NdVJP93rDk+/adtYnFk=;
        b=cTQO4F8q+NOFGQ4UTVj4x9CU5SjwYW7OgJtuE1DlLnFW2pU7iCSaNbAxbNwympXjfA
         szx+js4qiUcHRUKSlOg5kHM9KDDkfNyOmKo6vO6uUlNthuf5u1DeMfWYuMheY51CGHLc
         XzUjpj5lAZqsb3k+k62grnbZY5hM1VVVu75W3+o7IXLq6CyNGZQRB16Z2zDH0s0aUlkt
         7U8OHb8LIYoFB1mpO3F1UTJF2xsUGr1QFxUrPa3p2r8Xqsl69klfNIGjbtlpqxZgRaw2
         JL33nHHjW0xi6XtAHo1nmdOJIdWqAyhrGpfSMKsqzZgJSQbm51W1uatcGNIwZ/BX1Tf5
         5nJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772904395; x=1773509195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DyNcsAMM48Ztv0pJ1eI57h9NdVJP93rDk+/adtYnFk=;
        b=XI2zH1UeQ3cMMjEqSrxIMfC/5RnXyGNY2dy/NR7oxEHxtHa3iF4b9GLOA/Ve1W23cR
         9x+Mb19cLbaN1sAc2r+A5ehXb8x6l/CXAJP7uz+88FmhxD7Q7czeotFIRjo7axZJYTSM
         wZWUQ61L87LXDcrxuYsjq1+Fdv8kldqcZSCqrAGdNTtnWawJ/yPsUrIH36Kuc05pZWIz
         4+aGoTqXyCCg2+zXU6BnsqclcdWj1XLhXHOMuu22gbzMpilzklNJF+VhtC7z+KplRAgY
         5TM7xsEfOFE1giH7/HoMDuFZXAhZix6oFC9sOP7LoRCy6Z7AdvBUxQj9SuW1N/v13uQ9
         ux9A==
X-Gm-Message-State: AOJu0Yx5V4Msw1zJhzrZSIW8MsoVslhntBstVSqaDGr4WY59yIRDsGia
	LwuQKs5LVHVBei/ZzQM42C1CwtETadbY8wRXTNWAx+SzpZGwRP0b3Jdxy44W8e1y
X-Gm-Gg: ATEYQzyNTUsKOa1jzJQLPyUxyd+1ATCdeluByIVc7L9WCMqLd56aWCM/wE7I0YuXphi
	sMvhJGNHTfdP6Q/t2we6vRxkRmqezP6jI89xEnFt5Bl82cX5YZEWUT4loK2nDemtM6wFx8ZX36z
	3GyAombrNWLD//GkPa8WBqzrbHwbstQuyJCqqFP2AqU44YtopK0JpJx6/BdW0AjBh/zE5ulZOfr
	gDhJOo4ShZfGDkztzYykxjhPxzGgJ9gZeTtjyZ9U5u8I0JZKn78kzHP/pR12yKCuWm5hiJ9j6BR
	1pgQ8wg5sbKdpKaNZk9ehVCRFxWriT+zalKXvEsG93RIOjctDB2k26ZRtEsdRLp1PVL+DZVQfhg
	Kh05VXJYDfW/jr6g35fMQV1XzMVZtlFuh2UfreS0j7phvj5sjdjZAPPk9YmFrUOez/0G9hV33O4
	RnW9ZmDw0c9690AORQIJr9PD8ZEIo/U3ueP6LbcqjtB8v25uA5eWfEhQ6V+4E+NqQ=
X-Received: by 2002:a17:903:1b64:b0:2ae:62c8:773a with SMTP id d9443c01a7336-2ae8241dc79mr66548685ad.1.1772904395423;
        Sat, 07 Mar 2026 09:26:35 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:80f8:4f1b:d5a1:9c83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e57afesm56523475ad.6.2026.03.07.09.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 09:26:35 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH] sched_ext: Fix scx_bpf_reenqueue_local() silently reenqueuing nothing
Date: Sun,  8 Mar 2026 01:26:28 +0800
Message-ID: <20260307172628.4112680-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ffa7ae0724e4 ("sched_ext: Add reenq_flags plumbing to scx_bpf_dsq_reenq()")
introduced task_should_reenq() as a filter inside reenq_local(), requiring
SCX_REENQ_ANY to be set in order to match any task. scx_bpf_dsq_reenq()
handles this correctly by converting a bare reenq_flags=0 to SCX_REENQ_ANY,
but scx_bpf_reenqueue_local() was not updated and continued to call
reenq_local() with 0, causing it to silently reenqueue zero tasks.

Fix by passing SCX_REENQ_ANY directly.

Fixes: ffa7ae0724e4 ("sched_ext: Add reenq_flags plumbing to scx_bpf_dsq_reenq()")
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d5849ed4cd3e..f6bafcfe0b93 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8121,7 +8121,7 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(const struct bpf_prog_aux *aux)
 	rq = cpu_rq(smp_processor_id());
 	lockdep_assert_rq_held(rq);
 
-	return reenq_local(sch, rq, 0);
+	return reenq_local(sch, rq, SCX_REENQ_ANY);
 }
 
 __bpf_kfunc_end_defs();
-- 
2.48.1

