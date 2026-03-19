Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379EE39C007
	for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903686; cv=none; b=ktbzV7SDp/VLGIzlI1gRckyl1q553knsZGRgLoP6LRDG8ZV2T0P9VS9R6OxQmhyzYBM0bzv2z3bIPKJUzXbm1ziMuLYM7JmTJYInI9LalbBbNGCRGYR4SOy7+93BfCp9FVi+U6hc2S+1s/vohPqB34WVqUMTqQNfWtZwxRgJWS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903686; c=relaxed/simple;
	bh=7pRVvtnfeA0sa6j/32a2fr2cXpLjM9kRzp8YabBAVDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFRTfSak2TCJ9JfmIiH4T8dvxcMeHm+g4K/bKBUzA4pbhzjIYb9ILP0JEErusPxUYyuURlVQyuLQThHhYNjb2kgsVFW2AojQSUoqwZ2f8MtvOV5S6tg835X0G2KbyHU+YKH8YSO9zq9iEeq/cjwx+FxVml3md9nRjqTlkrm9CH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLbQ/JFw; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLbQ/JFw"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-829781b2b01so458896b3a.2
        for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 00:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773903684; x=1774508484; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDjQZl772sw1JcTEfS3inuR0WHQZ+cTg32nRvH9ymTI=;
        b=PLbQ/JFwxM99SWEL8oRN6iuo6nzggzokVlSfjJiMUzczeQtFwhzp876ssD/1R5gXsF
         l0M7n+PDihLmiPqnuTyAx1vJeJc5gyX24U1njWxy5YvyjmXZWZ0Yot3oT90Z8bhq2rUr
         EbHpplPizNtDghdBn3o2MGmkDZMjM2FLkMygUaXB9cpNYq6/Uim6KrFHDxt2oujPRZwE
         IQr7mPIYdohX7pOOGLP2RWzPhf8bFrk6asz6kLLUYdBst9RECN+n/LTHgZWucwTQNJ7l
         2Fpi/EwjVxbgSN2BzQkhvKAULwCd54kPft9VHtrj2dHItJnFmpEY8gJRScWk2Y3R1T2S
         Q6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773903684; x=1774508484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QDjQZl772sw1JcTEfS3inuR0WHQZ+cTg32nRvH9ymTI=;
        b=SdQpcB1bfLBjQaYuI6xyY1t6WouHk1nmENM3SbIVIjH28UMuEGDxJSp8cQIbwH2tbk
         TU2YN7AV9IybK7DEoXNucmkPguLjkZzV5hxq8BQdnTkjdacfCpOMMuW18j0aKogt6C+x
         +6txMySPIIgc7R73jGd1OnuHVJZdp4N5j8JutuFw2+YxMRbzaCUr/P0uWTmS9svNzsqu
         HeF9YypTwHP4RlmQiMSIAx2/40q674udnXVidXG075jfl0LeNZevdLxTcUMX5F51tY46
         o9PsNsx+9pJOQ+odeulFMQOXD46b5yGi3dxYMdgPDyyDt/vALoXYWj9jtIVmbPQQGLrs
         SgYQ==
X-Gm-Message-State: AOJu0YyF/6Cl42uqw6mR+7C/n83O00+BEq3YPjcFyBYj+N5VnPHvuPKq
	YNc2AGL2EMEn/TBYSxLX+pjESw1I1oB8vipWCbvjJydp/R2H9iQk/cs3jQeIDA==
X-Gm-Gg: ATEYQzwJF9ifqJ0AcJGXYOjxzRQnNJs42AP674aPbvLYFFWFHMplPi/X61V73O8vI28
	12jnSHxWBEb5WacEnOBDZsGGT0MCW56+yxVpoFrAD7I1+M6BJ26xG+EAj8OXaAVV4SruX7EyUf0
	MLeXpOk+kNVdtgehANWPAF6rFAFMC6nrDSEyDNsbNCpL9w/jT4FktKvVtgZaoePhjCl6YeI5Vjg
	adsJ/4OMhaleTehLGbUjIsS0+y4tBiFSLZs993k1Uo338uJT9Fp8ERbMwT0mPgOQQid8XOVKddv
	JhgUztXlkCH7YmvlPWyw5XNHlTcnfWQHVE/PZ9VvF9IRJSgS6Sif9ZmdN36s0T8MGNXCBVk3bkh
	U70QeG3uKkI6J5hANqM051MWqGV3YpvWIolZBMl6HyEew73XrYsuNPnaDi1CQacJFPBQQteMS1X
	4w1lcXjwouBoiwO0XOUkkeUr2njOl99L+srtHOq3vEptDipASgAN4ASrJMCqzh4vYLvLtDWUiVt
	Yo=
X-Received: by 2002:a05:6a00:2e19:b0:824:9451:c1f5 with SMTP id d2e1a72fcca58-82a6aeef14emr5874563b3a.58.1773903684008;
        Thu, 19 Mar 2026 00:01:24 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbe1ffbsm6599578b3a.43.2026.03.19.00.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 00:01:23 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: sched-ext@lists.linux.dev
Cc: Su Zhidao <soolaugust@gmail.com>
Subject: [PATCH v2 0/2] sched_ext: documentation and selftest fixes
Date: Thu, 19 Mar 2026 15:01:17 +0800
Message-ID: <20260319070119.575316-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319053026.447892-1-suzhidao@xiaomi.com>
References: <20260319053026.447892-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Su Zhidao <soolaugust@gmail.com>

Document undocumented sched_ext diagnostics (events sysfs file and module
parameters), and fix the selftest runner exit code.

Changes since v1:
- Patch 1: fix events path to /sys/kernel/sched_ext/root/events, add
  sub-scheduler path /sys/kernel/sched_ext/root/sub/sub-<cgroup_id>/events
  (reported by Andrea Righi)
- Patch 1: change "prefix" to "namespace" for the module parameter section
  (reported by Andrea Righi)
- Patch 2: no changes

Su Zhidao (2):
  sched_ext: Documentation: Document events sysfs file and module
    parameters
  selftests/sched_ext: Return non-zero exit code on test failure

 Documentation/scheduler/sched-ext.rst      | 70 ++++++++++++++++++++++
 tools/testing/selftests/sched_ext/Makefile |  3 +
 tools/testing/selftests/sched_ext/runner.c |  2 +-
 3 files changed, 74 insertions(+), 1 deletion(-)

-- 
2.43.0

