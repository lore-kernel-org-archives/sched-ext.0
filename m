Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC3B390217
	for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262938; cv=none; b=BPM/WU0cDK87P7HwAd2JAp1kbiKGy6ZdOowoLrHfeKlK4/0YgbaLLeD1ozj8NgNQCREEbcGrV1Vp43FEgDT7fmJPBjuvelA7Rpbtv0IV8F78nJVOUP98A5HfAyFI8hpzWx8ScA01PSyWUo/hdEG4/pSVshv89JmPbrS5j4XknRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262938; c=relaxed/simple;
	bh=hBC4hkC+FjByxumJcoHMnC4Hx5CpOKQgy3aludqIVxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQeJAa4AmrCCm/hbV1V2oGymRiPxXAPsyrds/g3K3YRiQ2NwgvWlRrJEv366bDwM6X14RilfEDBiCR4iTAilKXCKI7FymXLsAbj0aXHZ6Z+cUd+8Mu9WeX7qT6T7MzrPa/YwqVXWLICdydIueZaih0KaJyr7toppXro5La1AW3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLi3xwdI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLi3xwdI"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-829781b2b01so18007b3a.2
        for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 03:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774262936; x=1774867736; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCokYc1xzuktCOTLOg4K/b2H4fCbyV2EUc1+SzKkx9g=;
        b=HLi3xwdI6r/qqeR88k3VTJo+2FkX+RP+/2F/J+lwn7BgNJ6FEsN8+jTx8fjmhCZ02D
         ClIjWqiY0On/0OebzR15q2U1d0vED9tak8BXXZv0AGeB5+wO2i1ZKsEGY159xX+UaC0h
         VaZTxmg0NSQTFSxa0kzjCMq6dKjcW6G40Oex7iIyyU2iJ+AJx9MnmJTaz3PupneOQiAp
         fh+9AZA/bQiB7GedcBxCI7Rapg3qtyuz2+hdvMbAr1hZjVcxiCnkQz8dUXMxfO3Xajdb
         OijmeSaummn2o3aKKY6Y8c3jlAYaEdAupDiTAOcK5f6TZ+BPd4fMy8jR/pe4RSHKF6tf
         JRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774262936; x=1774867736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCokYc1xzuktCOTLOg4K/b2H4fCbyV2EUc1+SzKkx9g=;
        b=XP6b1EHpBQCrOx7qnPCZXhdHVQ6zWaTL7c7l9idqEyZ4WlfSapplE81mHegv7YKXIx
         w4W5cFwbsJLsCfIJqgIWLtUWRr3o75JmhQg8r9kLBaVO+fpr+LSVJjovFAS9ZJ/uk7rN
         nQG+A0gh3dcqJeJVhKgxBHRIeF5pOmLk/RAsfa7aZWj8NSxumGeglaf6RRg4Pvc9WSA+
         riBIQSZywWSG3ur8jHk433jPOXzttQniSBBHT/7frmyJkLm0uea1Ec/gi54+48ieqbsQ
         JmKzHJXmEgpi5DJEqgYgNzYCr5FgmplTdGB3WBUNeyAsr0NDi2c5eSzMySXQyh5jenoS
         mUng==
X-Gm-Message-State: AOJu0YzDZYTpQAAAZPMWAeP35tYIYgkhKmDmU+1vubUAORUu8T1snaUz
	BpCKB29tlrZqgMtGqxYfOM8OP+KEWSkBC6Fi09h22eQmF+u3TKbEiZLeNReqtQ==
X-Gm-Gg: ATEYQzymnO7OHtc1TGdPkoumZnLU3oKBfVnH0/xFQLL3V9vTxHMQhuIjhPiNC86JPXB
	SCZOeIx8FbBFBhRaTX7BBVFqe7XDUyT9E/fj2xKkN9Diu7Bv3N1dfiCaAl7W5r4BjqyEk3Z0o/v
	oZvoxQCFcVZeiqgxqWCCatvXlnpj7Jtjt2Q6FwVhpPxsWb5KvrbSZty3MPlyE45Y0d4ws6AERY8
	wYtikbLb7IPmNRHt+/2exeVhOOi6dSRKzMGquMbb5GMx0LfUt6riP+qAkVQwLtKe5l+dG1/y1Tl
	spp9nOvDEVIW9q1rmSDfB33aTsgaMJ3JvDIv1NXYrESAvYzyb2XX+Lt7cDh/SP91Ckz6My5iPzG
	uiBhGgiQh78Zux/q6PoogRTsD+lThzua0SEC0eLMHkgZFK+ZyNjV3esTX3ec+tgwu1ZXpoz3N3h
	c+VD/Mls0DAB9nREcuxJwwa0Ol54y485hyy/c3aJFesp7agGjy50Y=
X-Received: by 2002:a05:6a00:a04:b0:82a:78c0:6b75 with SMTP id d2e1a72fcca58-82a8c3933c2mr10641496b3a.44.1774262936140;
        Mon, 23 Mar 2026 03:48:56 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:a92:d962:9ffe:7c38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040db797sm9097023b3a.46.2026.03.23.03.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 03:48:55 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v2 sched_ext/for-7.1] sched_ext: Fix invalid kobj cast in scx_uevent()
Date: Mon, 23 Mar 2026 18:48:29 +0800
Message-ID: <20260323104848.3879920-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When scx_alloc_and_add_sched() creates the sub-scheduler kset, it sets
sch->kobj as the parent. Because sch->kobj.kset points to scx_kset,
registering this sub-kset triggers a KOBJ_ADD uevent. The uevent walk
finds scx_kset and calls scx_uevent() with the sub-kset's kobject.

scx_uevent() unconditionally uses container_of() to cast the incoming
kobject to struct scx_sched, producing a wild pointer when the kobject
belongs to the kset itself rather than a scheduler instance. Accessing
sch->ops.name through this pointer causes a KASAN slab-out-of-bounds
read:

  BUG: KASAN: slab-out-of-bounds in string+0x3b6/0x4c0
  Read of size 1 at addr ffff888004d04348 by task scx_enable_help/748

  Call Trace:
   string+0x3b6/0x4c0
   vsnprintf+0x3ec/0x1550
   add_uevent_var+0x160/0x3a0
   scx_uevent+0x22/0x30
   kobject_uevent_env+0x5dc/0x1730
   kset_register+0x192/0x280
   scx_alloc_and_add_sched+0x130d/0x1c60
   ...

Fix this by checking the kobject's ktype against scx_ktype before
performing the cast, and returning 0 for non-matching kobjects.

Tested with vng and scx_qmap without triggering any KASAN errors.

Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
Changes in v2:
- Update the commit message to clarify the root cause involving the
  sub-scheduler kset uevent walk. (Tejun Heo)
- Move the variable declaration to the top of the function. (Tejun Heo)
- Add an inline comment explaining the necessity of filtering out
  kset_ktype kobjects. (Tejun Heo)
- Update the Fixes tag to correctly point to the commit that introduced
  cgroup sub-scheduler support (ebeca1f930ea).
- Link to v1:
  https://lore.kernel.org/r/20260322171309.2640439-1-yphbchou0911@gmail.com/

 kernel/sched/ext.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 94548ee9ad85..f13cab38ea25 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4834,7 +4834,17 @@ static const struct kobj_type scx_ktype = {
 
 static int scx_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
 {
-	const struct scx_sched *sch = container_of(kobj, struct scx_sched, kobj);
+	const struct scx_sched *sch;
+
+	/*
+	 * scx_uevent() can be reached by both scx_sched kobjects (scx_ktype)
+	 * and sub-scheduler kset kobjects (kset_ktype) through the parent
+	 * chain walk. Filter out the latter to avoid invalid casts.
+	 */
+	if (kobj->ktype != &scx_ktype)
+		return 0;
+
+	sch = container_of(kobj, struct scx_sched, kobj);
 
 	return add_uevent_var(env, "SCXOPS=%s", sch->ops.name);
 }
-- 
2.48.1

