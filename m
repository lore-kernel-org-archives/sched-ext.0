Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284973AE718
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805829; cv=none; b=aV2PgShJBv+eouWLwIxYPEHkmyojr9C7p+ScLSvr1j7UdkR6uJDrd9b03EJfV01tejVbVO2RCm/RAct+C8yP9gDL0JltuCfmt0hcCm/z9arAezPnMiTme7Sb4rvVlta9n81cLhI9E98IAd7zzSz+2Tu92iRHu90uRRKn8MMWbMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805829; c=relaxed/simple;
	bh=KKJoiskobJLPVewH28+LF9Y4Ux/Lu7qzp3YYxz5tn6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ou3ZO09dF1whw6lONdC2SM8aMvdNtfsR/KyW+XB3524xQRv6IcIE7DEICPWBwXro1HbttnofY2R/hktQF7nM01+RdALorRy5LjXF3mlACqc9ri5zMGfb4kz9n1VRDD3oh4aO9GLEiBidLAW6Phd6a3khwzyrF4Kk4x0euOA1NcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zb709qGr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zb709qGr"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ab39b111b9so43336315ad.1
        for <sched-ext@lists.linux.dev>; Fri, 06 Mar 2026 06:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772805827; x=1773410627; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URwHQdDNBcfpjPgIZZmBOCF4w8QPrTIvO91J8esIlCE=;
        b=Zb709qGrJKSueKiQuHm8vLN0PFlv+Bpe+OwMuWL9v4JhWwNqn50MQrbKZyxgguVFBg
         VV+zzv6DDUztUNI8038WwSTLsAKt7YTljZnoUDNs3mWiYu1VlTJBhQweQM2XKzki9gGD
         3Zht4cfGu2Mqeli4pL7eoQhtCU8qGlfxaz1fcmA48m95vZJN578KwJvJofAhnnhAvCCw
         DzLBg84g2jBqJEjvOLssq0OgmEdS7nC+Nf2dCoWkkInn7i6WJCDZCUNiJeMy5bruX/Tq
         jikGuRwBuM/US0P1Ckz6r6VLO5ri2hAx4Q1Hf2Q32MyLHFLYIzbRg5ZTWn6jpGj027/D
         HuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772805827; x=1773410627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=URwHQdDNBcfpjPgIZZmBOCF4w8QPrTIvO91J8esIlCE=;
        b=qhkOnelqI817ZU1TZ73mk3WE018YkDIGTgi5aHy3bexaQcMRPm7RRij18/h+Dsxu4R
         AetcnRWu0Mr3rXSENS3rXL7C570pvKFvKT0H5Sf1JcYUl1LNTF/bdRUtw/JxZHGp0JIE
         HowX4qz29y/gDxsadbN4LWLfJokfZ8nV2fkqDCtKM3K2HSSR5IoPL71cTf2cITVVfNKL
         rzGibH6io7onAOwt1HX9tuP+a21KjkEJO1/1oeMbpfZ++06zoKHkSXBchlevV8heUy3f
         5WxCtviAehzDgQqs8NeLCOS+zgopbAEvqkKcoj+v9ArnniE8WQkYXGj0lKGElTiXCf1h
         21TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTJ4VT1zBnYD5/wb0QptqUQI2W3kx8dfAlpm7avRnHgUADJf9M8/BsX5urrdZvcI7+CbRdcOWZ5A4=@lists.linux.dev
X-Gm-Message-State: AOJu0YwIvsILqaqeaOcnAagqBg8EdLt/OGF9L0eCp7ks+8Oc7ndvIH2O
	6Tj0kPPxlkhFpulp/opHICkTOvTzUNVB23LSir8/ECBr7zeSoev8C9h4
X-Gm-Gg: ATEYQzxa5KBAacQjA59yTBKxyXzBYDfeCVEWTMqvR5NqBElnV8dlX5QrIDJ4D9SSzPs
	iCYMH4HI6L8kwqMjDu+mWFWAwmK0wWZtcwUEpt2gw9zrzSRjtuYMpE1xjPVu2CeLWfw4zI3q6Vj
	UJe0FTIZYs2FdMg5WvntNZsQr+05lZeZvtCH00ro5FW5sijxpVhwYjN2VNs7leyd4BcufpaK851
	6xaLLVcKQRU0SFHlZagW8+f/861YFca+x0JgHonuJ3EaNfQDLFDLqf8wd7RQDJTvUkhds+1e5ER
	xyBbydnztENDbOnCUJ9Xw4mH/5F+Pa1iFAvWgBDRh7sFq6LIU3LFvdZ/U78HYlvlpZu2b7z2NEZ
	m4AXAp9y4NiqAFcbD/oYSUPocUQsn8zOco84jUDXFPuUXtf9knvoQDZVKYl9jDkT1uc7t1L73/G
	tmNW2/5HROl1z0ighxASQliJm0DzhHgn829QyrGpW94qu6D5Fkvzl61HmzXb01Bntfa+scnjVQo
	XFspV60iLS+cA==
X-Received: by 2002:a17:902:db09:b0:2ae:5723:afa9 with SMTP id d9443c01a7336-2ae8253c933mr27839485ad.53.1772805827270;
        Fri, 06 Mar 2026 06:03:47 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840ccb6csm29134715ad.92.2026.03.06.06.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:03:46 -0800 (PST)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: tj@kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	linux-kselftest@vger.kernel.org,
	Su Zhidao <suzhidao@xiaomi.com>
Subject: [PATCH 5/5] sched_ext: Document scx_bypass_depth migration path
Date: Fri,  6 Mar 2026 22:03:25 +0800
Message-ID: <20260306140325.2710927-6-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306140325.2710927-1-suzhidao@xiaomi.com>
References: <20260306140325.2710927-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Su Zhidao <suzhidao@xiaomi.com>

scx_bypass_depth is a global counter that will be moved into
struct scx_sched when multi-scheduler support lands. Add a comment
explaining why READ_ONCE/WRITE_ONCE are used despite bypass_lock
serialization: modifications are serialized by the lock, but the
value can be observed locklessly from softirq context (e.g., in
scx_bypass_lb_timerfn()).

Signed-off-by: Su Zhidao <suzhidao@xiaomi.com>
---
 kernel/sched/ext.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c269e489902c..b1e5a95682c1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -33,6 +33,12 @@ static DEFINE_MUTEX(scx_enable_mutex);
 DEFINE_STATIC_KEY_FALSE(__scx_enabled);
 DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
 static atomic_t scx_enable_state_var = ATOMIC_INIT(SCX_DISABLED);
+/*
+ * Counts the number of active bypass requests. Protected by bypass_lock
+ * inside scx_bypass(), but read locklessly (e.g., from
+ * scx_bypass_lb_timerfn() in softirq context) using READ_ONCE(). Will
+ * be moved into struct scx_sched when multi-scheduler support lands.
+ */
 static int scx_bypass_depth;
 static cpumask_var_t scx_bypass_lb_donee_cpumask;
 static cpumask_var_t scx_bypass_lb_resched_cpumask;
-- 
2.43.0

