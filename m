Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBDB3A48D5
	for <sched-ext@lists.linux.dev>; Fri,  7 Aug 2026 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103152; cv=none; b=ucZXbSpog7rvse2G0LoNsHI9dy9WdUPIMavQpdzCEQE9IHcpSmlR3Co/Q8VEIfVgakCIlhBOHeVycKRkBMVBJ0s50VBNkyq2vbdspim72iVbw8tWB0mNAKkyS87Se8p0c6k5eaR2RToq6oqqtmeVlYu2n9KwIrluPZ4FKTHQ+Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103152; c=relaxed/simple;
	bh=ECpZSzEU9f93+i5ZTD4rJS4gi7Cg4In83VepeMsv644=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ms1rEXsc6pOoYSxMzXdiL/V+hNEsDUrTb7YUtRVpq05hE7iV45x7dJuixVpGnUOHr9HokYb2//NahejyHTyJXqQIqsI9HLrP0OQ1n6mJUux/52cvTLArEmlKVhVXPdyEeNTCZs9mJawvHs9evkANqYpF6wZxaje18cvAbKOSsbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYcZPViX; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYcZPViX"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso4059959a91.2
        for <sched-ext@lists.linux.dev>; Fri, 07 Aug 2026 04:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786103142; x=1786707942; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VV+ZKqF4r43ttqyVUVAkjNDPQOyYZFp8IxT6zvuD86E=;
        b=nYcZPViX7zZr21Frc+dTRw9S3IxXOVA1sPPzuRaygJihpuYZB8fFrP+jIoOfzmxl7P
         z30KEML67nxYkwZx8nGmmXnyIBB/9MjuYJUnXwyliVVynDCM5DtcIs+cUezP8V+96ka+
         1qoaVjQUAYGgx6V/4EaTH3ExpNZcAz20XFQTbzkBTQ0FegjKOjsTK0VpmcCYGCUR0wXh
         +BpAqqACZaARkw9P8szsICa4VzaALwHEE2hqqhKtF3OA+p7bw0sA7KHYWjfrR+C59q2m
         i8+cdwL+oyPHS/z2ecomniJ7HPAwGBg+mfHKdVXTgclv6TboaJviYZzqsVhAmsv7mBwS
         UJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786103142; x=1786707942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VV+ZKqF4r43ttqyVUVAkjNDPQOyYZFp8IxT6zvuD86E=;
        b=hiRvbq8Jed3EKWE6WDOR4wBHwf/Hm2XHiMcL7/yhq2fNzlaEdgHIGXH/D26AKEKTcs
         Dkw4gNURdHsm906D/TY4Zb/FagbNSOG9fyhtpuLFPW5D+6ZrDjtBtImyYzBIg9o/9G+5
         4ocbHXpCDQmjyzq+uzTV7McoFMwfBTKsEXA7V0HwmJv0sjmR1AAsyPeLbsovEOBkVvjx
         rn/AWD8hGy+XgEGf7A0lNvzgcK59xwynFukD8qVzIgSF5q+QCiDlxlsXEtym57RwZVtM
         OpgfOYl3xp/oNHycIjLebRLHEBx/cGSdQVta/MjzMO7MZuu0dBFz1NUcg0Y21SCG52I4
         n/Wg==
X-Forwarded-Encrypted: i=1; AHgh+Ro0w96WT12dTSqHWnT9sCmcgfFU6qYliwAttG5I8uXozQ0KcHKDOPBjBKFrO8yNVhN+fYGtGRGnyKE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw36sgpzhRKROP1e6VLtPvU6kV0+XYA9i9M5OmC3Ic5dzK3fZZ6
	Gqdzaj6pZbCEhkL9y0pScY9kf1igtAuBkkybbsbzilO85gYcfm+UtmnC
X-Gm-Gg: AR+sD10k4pzZLkXm374OL4q3aiaFX6aVj7dulL8fyNaHaPTdvAhdqSYvsTKqQQQ6c6a
	x/AjhCjZVJAUa4Z1FxpofIcRycWsCFxSGPRIf5urCu4N91h9qaBSPFraxyq1cgj5CXYUn/yo1B6
	a9MTTv3GYDgfpfIRT+IT81x1cyHjQT4i072ifniAT0saCItmAvycZRWL1G2nYug7M1A+BOJNbYs
	xckdqYGP16+E/UovrZglrXP9e9hRDPfoN5A+jel4vPdAYIIUT8Q+s5iZeBu3btWj/wes1QFWTLq
	7mMqsoe8VNFKhGAXvvbBzjZ7QoNbzm1FAXDeyP+WSUb15eNOfXfMdTqM/qXAeTlNjp9IDHcN9j4
	KH+BcZmHD2GxLsUYIpCKHeu3Msr8ceIsMhbU/OqujTqiMAe5Q3EoA4XV7no4gs3dPj8AdiLzaEG
	65AVzzSmRNFg6Cc7wCkH9sNGtLYhzfWH+9wCtvhcDdNArXBMxHz6nBtbhAs7Tx9cCM04Jjg+/c
X-Received: by 2002:a17:90b:2585:b0:38e:bbf1:de34 with SMTP id 98e67ed59e1d1-39261fdab5amr3985433a91.7.1786103142432;
        Fri, 07 Aug 2026 04:45:42 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39086164982sm4662617a91.16.2026.08.07.04.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 04:45:42 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Cui Jian <cjian720@163.com>
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix NULL dereference in find_parent_sched()
Date: Fri,  7 Aug 2026 19:45:33 +0800
Message-ID: <20260807114534.1253158-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807093838.56002-1-cjian720@163.com>
References: <20260807093838.56002-1-cjian720@163.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Aug 2026 17:38:37 +0800, Cui Jian wrote:=0D
> cgroup_get_from_id() can return cgroups from any hierarchy, including=0D
> cgroup v1 where scx_sched is never set.=0D
=0D
It can't.  The id is looked up in the v2 kernfs root only:=0D
	kn =3D kernfs_find_and_get_node_by_id(cgrp_dfl_root.kf_root, id);=0D
=0D
so a v1 id gets -ENOENT there, and even if it were found,=0D
cgroup_get_from_id() rejects it through cgroup_is_descendant(), which=0D
starts with cgrp->root !=3D ancestor->root.  A v1 cgroup never reaches=0D
find_parent_sched().  That also fits ->scx_sched being v2-only anyway:=0D
scx_cgroup_lifetime_notify() bails out on !cgroup_on_dfl(cgrp).=0D
=0D
Is there another window?  I could not find one in ext.c: sub-enable=0D
checks scx_enabled() under scx_enable_mutex, root enable sets=0D
->scx_sched on every live v2 descendant, cgroups created later inherit=0D
it in the ONLINE notifier, and the sweep and the notifier both run under=0D
cgroup_mutex.=0D
=0D
I am reading ext.c since sub.c is not upstream yet, so the split may have=0D
introduced something I cannot see.  The cgroup_get_from_id() part is=0D
independent of that.=0D
=0D
As hardening the check is harmless, but the changelog reads as a=0D
reachable crash, and that wording travels into backport and CVE=0D
decisions.=0D
=0D
Thanks,=0D
Zhan Xusheng=0D
