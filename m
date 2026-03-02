Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F9B38D014
	for <sched-ext@lists.linux.dev>; Mon,  2 Mar 2026 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772442892; cv=none; b=ud/FfRP1he5NN9VP4xOqfvcICkdeDyc8qvphvDhhq/d045eNh52ttsFkU5GG8NOFtmc84KT7kQnhPM2yjOYfS8U/ko7rXzTjOP9nkVqrLNpyKq4g0p6dQk6Kk34Mr7EVyaLseMKkKffmP2LZDp6b3WVDKe86ESvykIgGivxyD8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772442892; c=relaxed/simple;
	bh=mqQ1xqyijcFk6G2ohzrkaC2WIRmYTASGG+OJDAiXtEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INdY5JNx8bPqjIJduNhktMAAlwV5OVhe/xOPhSeTZWXeZliXM+cqnDS5pl+YWVIvdSoF8lVjzF3kuEU24bILj2SoYj5r0RJ76/FCygyscelOsf9UYtoUyOguXneryfBmMbIAALeSVFOUXQnxekA/+Tt9uFFHG9ovEn4xhu9nAu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elY1Zo3K; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elY1Zo3K"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c6e2355739dso1684579a12.2
        for <sched-ext@lists.linux.dev>; Mon, 02 Mar 2026 01:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772442889; x=1773047689; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xp4h+20tE5YCAazww+ZGLMD2jeF+NfRy9eju/1nS0pk=;
        b=elY1Zo3KuCrbuNsq+q0COhTanh8JFUaWVCdzi3LzSdv0DniErLMPORB0JuFAwpoDtm
         k0ZMSMueRnIDa5EfZbDznEX6mpQd+Ov20vRVM5BtKTq4JYRp5+E32a1z/SETHmfC8cNy
         bI2sJTiroK/U22HJEBLGu5OCjdAH/5MV8UNJjp5K3qjb4h2IXbImWDEqnIKQF3y7Dz9m
         HYWsSB7vXT8scpFoEW2mnZeRce47mJ1XMWokY2dx6+t8DrKllZ9nxx61iu4U+Iwmkr4V
         b+MWpv9g08tZMYd2lLIZAWtB+TJKxhlDtsSVx1r8+GaPjhFo5UdUSWG/HCVNZi1853CR
         U2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772442889; x=1773047689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xp4h+20tE5YCAazww+ZGLMD2jeF+NfRy9eju/1nS0pk=;
        b=lN3ORndbQy39uv+MmaKl60yVYYO2ZkIJ9w06hqKhHOBAWtAcU4fZrJNegQwCiba4ky
         h+GGBZ8R77X54q5udGd7zMgJ9fjSjaUEAXw1yuH9h4iZY041SYwEHqveHzOWsJohKIVz
         APsgmgSXGw4EqJe59ADtG03VHa5RylsIl5KtjJgh1/iNLKKOEHDithEezyjMh2PROMSv
         zXrvokksUdBu7aK4AfG2DzwGUFHAtA3p3Lvmy7QqXm1k/bdM5iOKecG2G4IhZRAH6zRI
         BaeXV0jU/4OzAjs2v9JhV52GptRyksb3mLaq2la+/KnnZVbOzd5eh914wO5ugXBwXKBl
         rDdQ==
X-Gm-Message-State: AOJu0YxNer6iGV4bOuJfCKsXWXBbNnJduzNz882Lzgsz+8YUx8creEVj
	L+BSsB/ptOXEgEDdCTaBkYGsjoLXBmAECk0vIG6AJjkB/HpNAM2QRkVpLzlvVkGB
X-Gm-Gg: ATEYQzw1ij/Rww8sTWfLg2kXZWtkoO2Scqc1KHoO7XD+uTTHYrh+5c11pdmuwAVnDY3
	Oz7IKAAIDr5Egk8bLJafTk0UOIO5APgQdm6Fe7gYw4Dh3LgXGFIeuaeEipOW48WODISrCgj9Son
	UgSrPvO3UKD7W9GcxtKKA31tqUniqc5/4jIK+LZiBGCvLiJl0m7xu3ui1dDFPpA1POUU/inNUwd
	3l8B4RUi3DWy3tnI8WZDuEbC5v5eqqVIStACuaTasz82z6dUY4MxqU1EJAe4Hz06RwL0pn/4vfP
	3bb618g/Nqm4mSQ1EJdQQSX6dOPWdbx1q3PzXXvH/oTVJxYU6aVtrUUIDW8WmURXQVP5wCgj5ZC
	vFpNe6YXyqFhK6pnxSQ+gvr2MWLv7JWJ4duOyk6XaI0JivhCbQYbMbf8y4y/y9ZeIoSuI95AvpJ
	D4QvsU7QSFvhzoSViGgDAx7weti0Agkbpf3VDX0Bs6TP/MK6rxwCoytU41ErW9XbjCKgOiObBaO
	h2pLIRWdU8AKbI=
X-Received: by 2002:a17:902:ea02:b0:2ad:c527:e9fd with SMTP id d9443c01a7336-2ae2e4b5a34mr130433495ad.41.1772442889308;
        Mon, 02 Mar 2026 01:14:49 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae496470d3sm39729525ad.15.2026.03.02.01.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 01:14:49 -0800 (PST)
From: zhidao su <soolaugust@gmail.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH 2/2] sched_ext: Replace naked scx_root dereferences in kobject callbacks
Date: Mon,  2 Mar 2026 17:14:40 +0800
Message-ID: <20260302091440.3973220-2-soolaugust@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302091440.3973220-1-soolaugust@gmail.com>
References: <20260302091440.3973220-1-soolaugust@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhidao su <suzhidao@xiaomi.com>

scx_attr_ops_show() and scx_uevent() access scx_root->ops.name directly.
This is problematic for two reasons:

1. The file-level comment explicitly identifies naked scx_root
   dereferences as a temporary measure that needs to be replaced
   with proper per-instance access.

2. scx_attr_events_show(), the neighboring sysfs show function in
   the same group, already uses the correct pattern:

       struct scx_sched *sch = container_of(kobj, struct scx_sched, kobj);

   Having inconsistent access patterns in the same sysfs/uevent
   group is error-prone.

The kobject embedded in struct scx_sched is initialized as:

    kobject_init_and_add(&sch->kobj, &scx_ktype, NULL, "root");

so container_of(kobj, struct scx_sched, kobj) correctly retrieves
the owning scx_sched instance in both callbacks.

Replace the naked scx_root dereferences with container_of()-based
access, consistent with scx_attr_events_show() and in preparation
for proper multi-instance scx_sched support.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 kernel/sched/ext.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 718401f4ff2a..f25340ac044a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3631,7 +3631,9 @@ static void scx_kobj_release(struct kobject *kobj)
 static ssize_t scx_attr_ops_show(struct kobject *kobj,
 				 struct kobj_attribute *ka, char *buf)
 {
-	return sysfs_emit(buf, "%s\n", scx_root->ops.name);
+	struct scx_sched *sch = container_of(kobj, struct scx_sched, kobj);
+
+	return sysfs_emit(buf, "%s\n", sch->ops.name);
 }
 SCX_ATTR(ops);
 
@@ -3675,7 +3677,9 @@ static const struct kobj_type scx_ktype = {
 
 static int scx_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
 {
-	return add_uevent_var(env, "SCXOPS=%s", scx_root->ops.name);
+	const struct scx_sched *sch = container_of(kobj, struct scx_sched, kobj);
+
+	return add_uevent_var(env, "SCXOPS=%s", sch->ops.name);
 }
 
 static const struct kset_uevent_ops scx_uevent_ops = {
-- 
2.43.0

