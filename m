Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1A93CCA02
	for <sched-ext@lists.linux.dev>; Tue,  3 Mar 2026 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548541; cv=none; b=DGU4dEh6Z9cnmG42brqFHULFbZ8KEDV9MWcKrb9zfNBbEmMiYJMavPyC7CKAXTEqKII6SndZqKcl0IU5O6I+Q9lNOc+4hN1bNFTVjn9VITpc6l+E/cGtlOCXAHlIvxfdH7GLKDFMHtjvd9jq3FgwUFJbFI3d6xskGLEwQTfwA5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548541; c=relaxed/simple;
	bh=q7Y5Zzbh8pXkTN92/rTnktaEWgUUEvuLTqrdeK+Aqg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkImEPcTFdrNx/r2FmjLedGk9GiFsm296u2mDpZHq4g8oGIthaNLVgRqJI4gMIdA/eyCdpd+DPgTJROxOk/qIE12JQ1QSHEZfp5R+ITwwNZzrLlMmxjNtoSlZk7PcdYpOXaceKy3ALHHd/nZCJ5MPYjA5ysgP+vc9O+5smYWoAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrzfvTW/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrzfvTW/"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ad617d5b80so37075325ad.1
        for <sched-ext@lists.linux.dev>; Tue, 03 Mar 2026 06:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772548539; x=1773153339; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFssQuWEuenbEvgedzsjpO9OJU4530KNkfpCqhhzSrE=;
        b=PrzfvTW/j9zqaMox+06QKqEot0XR5trg9W3t4KTnyQnExXss88Aq3vfK69ydhVpcHa
         KBHnWNPM+zOoncsMSDtnbu4rWCso1pkufm0crL2BRo1lWD4GWRJzbZr97z14KQmMpLqZ
         dq5FQrlx6QRtd97xcWBHp1FhF+GU5xsQo3irHQTrB/dDEurgSYfSGL8RBBrRmKrqqes6
         So8cQvIa9L7zPBVdsI3C5f1NxxvgM0Y+pEIZrO0pHC1L/9NMaexyUfQbWxuW3Miv87o2
         jlUDKNynBLqzT+LBgXnWMR02gVrR2bcn6COzIKPPDe5/qCWuY19Y2SLC7JDOvUz6so1n
         jQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772548539; x=1773153339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JFssQuWEuenbEvgedzsjpO9OJU4530KNkfpCqhhzSrE=;
        b=wJ2qaAqI45Pgd3GrmkPNVg6ErLjZpN+uwxQHi3I3yPBwSGBe1eC4tOjiKNR9i258AI
         OTvYHvPCpspsjiNwMUIOwuVfqhSNwgDSleVRDxtIagVRM7g4qqoTgUDwZtYDhjh2kOCY
         z2vZBwjkqaN6cNlaJ7MIiRu8JrltFBCJLKIIblC6OTKLETHgIQssrw9lHT71HmMSmhkF
         IZQUjrgs/gWkkdR32LdQACB9xKuQiBHRjBl6nB8gGYj/Y/W0F5PkS5TuokeZy6Jk3SkN
         B2sZ2BLRx2hQZyxeGRCcrqS/rq0Q+lDTqGrh8rMviMXKiRNJEG21oeHe3FT2GkKQjsQ6
         EVMg==
X-Gm-Message-State: AOJu0YyPR+u5qWrR6cg0EIpkIs/bL39ueYKsOJfpYZ+ps+3FE1ck+tPC
	c9b/bdSxa2IFu79liFDvyzPUwR5eGAvQY1RHLyP6xzZokaURbjLVEhE1cAA0lhaI
X-Gm-Gg: ATEYQzxs/UjYuBMOCIFIyF3gfBiiK/pRQrGjVbpZDPX0q/tHJP10j9uw9tWe8XXJvty
	jFff+vpgh2e3gMMi3ZVbgW5JO+sElAc6XuUHmNa0KPDWEtFInPJFw2DdZkNtet5Wu0CBS+HL1P4
	S765Eth0lUPlFHNc9wBer6Q34s6GLXl6cF69ftyDmvHKUoEfXtPAiZv+m6QlYEOmxNhUwnSh/UZ
	73r0d2zowDFGYWwNIau/WkFx9NnkWPyMU6uRl6Yqn0wTF3a+V/AHe4nm+DFuIdVJ4xXJM5LJ0Jz
	N014wvAYigW3f5rV1bqoHmo8B/VGHRr82YLPdvvRTL2f8/wjKBr7dBFNAU13IKFZuCh9WVd9l6n
	1gamU0srgAX3b2Tz9ro6xBv7Gi1R/dXiPyoYzIA/bO1Ai8BpLIdjaKnjDg+ZVOcfKrBusoD8Qap
	J+JnWol7AcQ6Isc7eq4xYBuUD22JuQgCIZMhpdqyV1SKRFHlAaHgE=
X-Received: by 2002:a17:902:cf0e:b0:2ae:51bb:97f4 with SMTP id d9443c01a7336-2ae51bb9c7cmr61641625ad.49.1772548539225;
        Tue, 03 Mar 2026 06:35:39 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:af56:6148:37d:1e5c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae534088c4sm76847025ad.26.2026.03.03.06.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 06:35:39 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 1/1] sched/ext: Remove redundant css_put()
Date: Tue,  3 Mar 2026 22:35:30 +0800
Message-ID: <20260303143530.135968-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260303143530.135968-1-yphbchou0911@gmail.com>
References: <20260303143530.135968-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iterator css_for_each_descendant_pre() walks the cgroup hierarchy
under cgroup_lock(). It does not increment the reference counts on
yielded css structs.

According to the cgroup documentation, css_put() should only be used
to release a reference obtained via css_get() or css_tryget_online().
Since the iterator does not use either of these to acquire a reference,
calling css_put() in the error path of scx_cgroup_init() causes a
refcount underflow.

Remove the unbalanced css_put() to prevent a potential Use-After-Free
(UAF) vulnerability.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2ba69b302368..eab6e09b6442 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3589,7 +3589,6 @@ static int scx_cgroup_init(struct scx_sched *sch)
 		ret = SCX_CALL_OP_RET(sch, SCX_KF_UNLOCKED, cgroup_init, NULL,
 				      css->cgroup, &args);
 		if (ret) {
-			css_put(css);
 			scx_error(sch, "ops.cgroup_init() failed (%d)", ret);
 			return ret;
 		}
-- 
2.48.1

