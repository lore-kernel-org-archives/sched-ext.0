Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E31D3932C4
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801362; cv=none; b=aXrrlxjMqICc9lKufKe0F2IgtaXA0WU+hCh6+d9XMuqlBV04i+TYi8P9s/Nx9q7fSR6lMm+Hp12PkG/yG9VSLhJQFRaBuYF0tGrj1jl297LK58shwmY450krPuG0Ix1QMJt2EZA6uS4X1YhD6GxfmHaNM5zY1CZjd9igefuBQUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801362; c=relaxed/simple;
	bh=KKJoiskobJLPVewH28+LF9Y4Ux/Lu7qzp3YYxz5tn6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QgsUy6jNNF0GXpTL2dtsBAZHcAy146FCLT42goghvdahWHgmkhuL94z9subRXJkGRidYlsT85WlWBoxI+H+8JfT/aYxz517yI2ZjXpe2w4g9+anYvF0xwcbZfHQOivQKHtARoQMcamj6NNPhes8KiDAjQLvjw5FF9+pQUMOf/hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBlz9rm3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBlz9rm3"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ad617d5b80so59848155ad.1
        for <sched-ext@lists.linux.dev>; Fri, 06 Mar 2026 04:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772801360; x=1773406160; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=URwHQdDNBcfpjPgIZZmBOCF4w8QPrTIvO91J8esIlCE=;
        b=bBlz9rm3jEul6EV6WhRJ4aVur5voQ7APM24q0E1hbRj5blw3qhnFjV0uY6Y2g56uJt
         +MlQk4tsiov9iKfPTOHXE7mOyorgXDk04rqTeR71paWacaYJeey8Seo3TL7fbn12NhnN
         Vw5bNiwcCHDDbWHhgUrC4u03S4EQceiUU4TbGfHg8nMI9Cuc8T/z5RZRwaHOVosIUZfG
         /xWK5WAO9EkxSrnZp5iupiWScJyW9xa3Lvrzkn658Febaic7TJdVfvcuwW43U4qRHJyK
         acogH0g0LO9LY5GDHR/inJcHUi0Yv8jYFv9mKlRp85ql01+Bramig0jtkyOjiRzQnbx6
         NQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772801360; x=1773406160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URwHQdDNBcfpjPgIZZmBOCF4w8QPrTIvO91J8esIlCE=;
        b=Vg791gm0LdoI8oYQhzl4SJ3afqwjlcnYXe+SXX+vJYfjXcwNj5tj6GWHny5waMuTEi
         SkLKw8/MY00SDfBMM6Hts/sXeb8vh80QaT2SmFQG58pBeqmNuoFHC89IRHfa1oZdOzby
         6JE3GnJAniSrhWMqojlyjp+6zbg7pJU50dyKoarz8ywRJGQTM7wqchZQ/mprQMzwrH2+
         N/rIVi5h4JqfXBV8y2xmRT/8N4BNEB3e5Wypr5tZS0OUbPVQtGevWqNZaGX4RG3irHTs
         uCoBTtSEpsGnaHOjyiHcDd5KCUXo6Gt+/Hug2yrqxy6f8GkpEudxnAoKzkZ3n5X6jAsx
         9Quw==
X-Forwarded-Encrypted: i=1; AJvYcCVH8gg442XITWDHMc0gulBbBRrwMr/NINhHLw1afm2Eoa6Qt1NaFSjeAZqWS+6l8LR3z2XCzL0VubM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9HI+9W0t9DlB6XSnGWQ91tPCVwjz0lMd4O4SUQ2oA0qNWApk8
	S2pRDDAaRWm3kQvJ1QMEstbpPi68xmMg2dEEiIKi09oeX41SQHSK2Zb+
X-Gm-Gg: ATEYQzwkW8Hvc0erE1ad2QKib3b1ywE0zFWJJqRDMQJ6cW4JHLMzYUfeVhaTjEtNBvc
	nHGk+MLblZOIRmkO0QHLRiM03t/gyqWvGH9pF26xbCOcvOQSBujyDF0I350gJYD7A4dN0WIQij+
	Kj5RU7swPA1C1i2M7p+HArPqlCI8j67Z7yjkwqjXp5fHdXh/Ht09t4GMeBa/oG3VaBFiQSWpWe1
	2fQFm6s6dakujzT9o+3AUANLUTH3afxOR+QskW+KiWy5mdPnE0oV/oZlsvQnbXJY1Q105SiA999
	DUWQhFh7F3UpR5jIs0wITdoQUfIi6YPipREBRIstSi/YLaJuhpMKrgDCD4w4NdMEuHpNzWhcIEs
	NUAZvqtXtgrCB3KkdeWMYc+u2KyyrIGAROzCmm7jCcqNnRtGEHPKBGoMBRXExalxzf7xIco1hq3
	0TUFZk4n7jKJS6LL8cewAMyvqIki3cZoxJzhxBa0zd9f6+aduR8lpq3uvaHMzVVkBdXjtlW2+ij
	Lw=
X-Received: by 2002:a17:902:f78f:b0:2ae:6829:d550 with SMTP id d9443c01a7336-2ae8246596amr19671075ad.23.1772801360439;
        Fri, 06 Mar 2026 04:49:20 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e78f77sm27712845ad.21.2026.03.06.04.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:49:20 -0800 (PST)
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
Date: Fri,  6 Mar 2026 20:49:01 +0800
Message-ID: <20260306124901.2653465-5-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
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

