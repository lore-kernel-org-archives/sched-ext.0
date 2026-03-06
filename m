Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C425933ADA0
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772794748; cv=none; b=Ziy6WlL0bFyjvdWVp3fzIZ7cD9LRbNLmlvgntlm4+jAEYYmOkpHnop1/f4z51Pn4XlrvHoiVZNU1sQiWk3KL7EyovzK5SgGXaZhw/IIIUe+7siJl1qJt+QWDT7qAXVRkX5UABcyqtpwbwLIgluD9GixSG2DW0FG8wD4QrfwS+kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772794748; c=relaxed/simple;
	bh=U9vfN3aOervp6BiVrSrKKN/8sXJHVbme9yQU946P68M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V87diFccocAw8f4F9QLQZ16aG5d+/TeOqN8wOsha1RLVL2dpK/QBxTcFrwlWiodBrj3OJJ7WHPJoF0PPuVl3By5O4IcZvv60XhrG+sk6mycEMsFDG0ASkXqLV99GkZCLZughVbaDbbMqapnTxZV1TfJcVa+iiQA6/eRGhRcQDMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWHG89J7; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWHG89J7"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so2884161a12.0
        for <sched-ext@lists.linux.dev>; Fri, 06 Mar 2026 02:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772794747; x=1773399547; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VJX1Q5TDY8tDQM4DxMBMHAJp5Yfs+Kh2ac0xcWiEGwA=;
        b=HWHG89J76pYloUFlvSHM+CsBtam1jbU9qeRck+ZrkyiBgsk39ym2vc2yUMS8g4dIMH
         e6bzE86t9vGBOB9zywt5pg4Oalt6YrSXlHoVD/ApTY/Qz8F3jIj07nJkQE2COWLzyxm4
         6ZNwl2UNqYMEgM4vvtTd4OfX7z8ZRPZilIIqEYCrdLEpQ1jfAaFGg8gfQR3S8J2M+X7A
         YYolSYXl34mGn0avK7hoU1krypWDxqbDr7kmM9QN2hQZXIjaawbZ2HHJdGuHc0Q8jGRf
         ZE9h0QR6vdDLDVRoKfXIAMlLMuxMUADPbIDHqiT3OTgRHYQi1jaImKrpcoi7x5p7kJVC
         zz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772794747; x=1773399547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJX1Q5TDY8tDQM4DxMBMHAJp5Yfs+Kh2ac0xcWiEGwA=;
        b=A5NFCIiSZjCnW72K4D/w5FaX8DTwX9dA6fnC3Fwt6ns6quT15yUgyvFtEj8gaYLKMT
         xGcTELbYoEPvUcH0HDwpcA2BTzN911Jku8rXAFL+pWI3u0tCyAUNwB/f8NkrOjCiECHs
         5jsDpPh1NESE3E6V55PHhxEbRTKGELOj7MGDEIxXcT7/T5sdkAnBVOT6j73rIWxWFZHV
         iIsw93wbd276CEfiEj3kWpNwm5brJvtfMAF1WFatZVkcr8uTL4iWW6hTNjMBKgFAywRt
         DTYVw1v5Dn8o9U4i8yzdto1ETJttw9O7ZAafB9zJILd1agXj7GgVofGbfY18vWluNNiV
         zguQ==
X-Gm-Message-State: AOJu0YznjI23qycepLh8pYg32Kqi70HeeOdM7888uVWn9pCHhO1eY+1D
	5Mg1cVVhy/k1RFT9HnP+uoUCcAU+J7vrimXV1vsXooMnIkSkA6POKonkUayQAq2y
X-Gm-Gg: ATEYQzz1ZPx/tNG4ciemFAXkiFee48huWYn+Ucb19IKrewPR2cgCxI8gorPMoe8u4LV
	e0u60HVOKMd4HlyWi9d6Ikg10sSyBxJKlmdLx+Zig9rXNk95mScjG3j7brI5qxpfuU679rRQW9m
	AZKS4Yj2GFCd8NuD6Ht2h5p2w3f/15AblODAQ9cer5WryexmloOXpiRPO7f6xviYCRIlFHZpojO
	v2G7iLfvqmUUipk5xRMyy8vA//olq5VDx/dlc09QFgL44y40jhgWBvQnsFu6Wbn28ZGyAlPzZm7
	V2rRHa2C73db2e9g13KqfGE+/VVaLLLq6aLWTSmiGDOaRYTlHHEkgkFNE318VCNs0FKeXn7zeZt
	QcK+cZ8NANfIFc4cPskmUpzmNEFNPAdDPOsUd+dJi1+tYykxQfeqgeZ2mTrL7EupKo2d57zu0MA
	JDLPUNSN3/ZLYP6mkVvchA2j38uD0CW2y09SkgSIdl6pC/yinT77HFN57ZmYwSOsBMTNhKiE1X0
	Sg=
X-Received: by 2002:a05:6a21:7747:b0:398:5f2d:5ae3 with SMTP id adf61e73a8af0-3985f2d6222mr862516637.66.1772794746915;
        Fri, 06 Mar 2026 02:59:06 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739dfbf4fesm1427037a12.0.2026.03.06.02.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 02:59:06 -0800 (PST)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH] sched_ext: Use WRITE_ONCE() for the write side of scx_enable helper pointer
Date: Fri,  6 Mar 2026 18:59:01 +0800
Message-ID: <20260306105901.2543743-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_enable() uses double-checked locking to lazily initialize a static
kthread_worker pointer:

    if (!READ_ONCE(helper)) {
        mutex_lock(&helper_mutex);
        if (!helper) {
            helper = kthread_run_worker(0, "scx_enable_helper");
                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                     plain write -- KCSAN data race

The outer READ_ONCE() annotates the lockless fast-path read, but the
write side uses a plain assignment without the matching WRITE_ONCE().
The KCSAN documentation requires that if one accessor uses READ_ONCE()
or WRITE_ONCE() on a variable to annotate lock-free access, all other
accesses must also use the appropriate accessor. A plain write leaves
the pair incomplete and will trigger KCSAN warnings.

The error path also has the same issue:

            helper = NULL;
            ^^^^^^^^^^
            plain write -- KCSAN data race

Fix both plain writes by using WRITE_ONCE() to complete the concurrent
access annotation and make the code KCSAN-clean.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 kernel/sched/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9a1471ad5ae7..c4ccd685259f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5355,9 +5355,9 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (!READ_ONCE(helper)) {
 		mutex_lock(&helper_mutex);
 		if (!helper) {
-			helper = kthread_run_worker(0, "scx_enable_helper");
+			WRITE_ONCE(helper, kthread_run_worker(0, "scx_enable_helper"));
 			if (IS_ERR_OR_NULL(helper)) {
-				helper = NULL;
+				WRITE_ONCE(helper, NULL);
 				mutex_unlock(&helper_mutex);
 				return -ENOMEM;
 			}
-- 
2.43.0

