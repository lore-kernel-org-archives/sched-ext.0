Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E4343CEEC
	for <sched-ext@lists.linux.dev>; Thu, 27 Aug 2026 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824616; cv=none; b=fDZ0YPL7/3GS2pA64S3xYXcw3OeaY3CN/j3s8Cj70iXgxwp5t2VhOkHM2K1lfHygaE7EdhWkdbp63OpKLYXPGE9EjEyFpzxQlK6j+281q5aRLIkfgGIla9eF8NJWu0hOScqnoh4NlV4ClqoT8hUtd0afJStJkKcQJeI7eSgtrsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824616; c=relaxed/simple;
	bh=ZsgSEkFEThAsuNHtCMgJ2lAhqARJk3KNgLFl25kjaN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSfjXqqkpM42LfYMaDCadAq2TQWH2isnRqMDSDzwLYlUv0G1cAdVQG51HXZDgQgKcT8AnGmntdNsVyxLD0zjLmZDLfeO3/6oN9e/DM0yxmbGW+L29krPtbZHADpu2PftawtKrAEraIsUThBZnrKV4VC8bihmbOhRYEG3sxobjcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J56gl+KG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J56gl+KG"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8518b3ff3e9so1506350b3a.2
        for <sched-ext@lists.linux.dev>; Thu, 27 Aug 2026 02:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787824603; x=1788429403; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZsgSEkFEThAsuNHtCMgJ2lAhqARJk3KNgLFl25kjaN4=;
        b=J56gl+KGiDd3epXVfTEDZLCwXO8VYgSD5XNDsC52suHNyz5RLW1ce5mnxPDQjDYPfw
         LEYajrfCsW3B4Ll6JOPJNTwveOw6ee9ttzEOC8ip5bposKgXSBQIF/sMWm/E17DUkNGw
         HA9bI3zV+J+v7g4VpQbitVJeMqS1bMigfCkY1VgKLSM2vfB928RiNQu3MgqWX9nndBOJ
         HBbQDv6lTQaUm+6fY/6yUBuHKwJMOnRhmAgDqTAYzbiuku8xMNGb297zzU7RYdgvbyio
         JS1KQbzLNQVDqc7/uJEivlBo3+1de3F4KRyKGtMff0iMFay4EEL33nHR+/1ARl9xbDHo
         XQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787824603; x=1788429403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZsgSEkFEThAsuNHtCMgJ2lAhqARJk3KNgLFl25kjaN4=;
        b=mw88bDf+wlO5dpMba0OktaRLArRvyKkYQUZMOEFni8xi/not/jbUgK8z4K8DaLeKTc
         pNhSzcx426jSnyfj2wGJlBwPGw8CvhTBv3o3v6S8QG40ORlrxa+D/SfdrVeL3lFBiLcD
         BgEawyBbnZLybrP2CIK5e6MH/8mZ7AYcsyVkhhw2ttPEGd+B4js4lJIPTCuSWIyTiPaC
         0SwpEgOf27sPD98YHQkww8LNh9WF9MXMO+cNgBWi6NV45QSq5piYghjlpjqheB8Dzifa
         /hJku9xIa3ijQERHTBzF1ks3DJkWdCj8sD5+aiIJkX5afETmf5EqJ7ibo10hJrGa3kMY
         8HZA==
X-Forwarded-Encrypted: i=1; AHgh+RrvHW//RBaPNA1hGlCmCmoYbBGJ9vqdRK1Fa76sAdj4IHyytcpFXIHgEgMOy3d47yareE29v4xSszY=@lists.linux.dev
X-Gm-Message-State: AFuF++kqtcbWGTv1SMxmpv2Nhd6PzMTWcFE+3YuBNOZxK8h40Ut+HsgT
	aJ2M4k59iWkZZ/9iwA8MBIJtxk6i1rrn7HFTclAkNkrcrpHF94CneqsT
X-Gm-Gg: AR+sD10mdVLAp0wnyZKnGdT3cAA5xPPyDfwnlZ3Ew3opvRqaiU2pBPcCmDW6tR8Qe/6
	hOArM7fCeFjju6X2Twk/pJzKf9UpBxyMXH6XbVvTqOKMrypWZfNAJJrM0Q42hW2bVMJRCjPZeaq
	sko66DnJTWcRhv4PfoslCAXUnKvq3YCH8ALiv/85CH5pnmbVRRinT0YCsgHtzjxEYeEb/ItXpJJ
	uh28sEUzcnqk2yYYcv5nClfjq0UR47ZGl6+0qshC2S+lpR0STwET9NJHkbao+7TfWsZXD3REu3x
	9uCvyvAN3IH3nLr6Z6iYklSBsXNa24Gg3UyEw8vLqEDW3qLw9UJhvaT+oHIGb7nZBl8aPdt+8jw
	WkfQHkCPtMNcszUUhw3NEV2BJD3ZRBeHDxcqSgTH2pWmZQHSs5igxQm8HHhuIJmVD4U3hxJ3++A
	szE976WtD0ZWo7btLAAHrz4V5Yp4pOanfUxwdYUN0Zu8DdMdt9uZe9LpLwqoWhlvFNVbaGmkrxY
	CWge5qgy6VRP5s=
X-Received: by 2002:a05:6a00:1a13:b0:855:a211:6679 with SMTP id d2e1a72fcca58-855a21188f2mr2342124b3a.5.1787824603352;
        Thu, 27 Aug 2026 02:56:43 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535a8b8bb2sm1819592b3a.16.2026.08.27.02.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 02:56:42 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: liwanwu@kylinos.cn
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH] sched_ext: Fix several comment issues
Date: Thu, 27 Aug 2026 17:56:35 +0800
Message-ID: <20260827095635.535908-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827091411.973621-1-liwanwu@kylinos.cn>
References: <20260827091411.973621-1-liwanwu@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

Grepping the tree for the old spellings turns up exactly the lines you
touch and nothing else, and the new names hold up against what the
comments around them claim: __setscheduler_class() does return a
sched_class (kernel/sched/core.c:7608), task_should_scx() is reached from
it at 7617 and from the sched_fork() path at 4862, and the @running
callback documented at internal.h:439 is the one set_next_task_scx()
triggers.

Reviewed-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

One thing for the changelog rather than the diff: it lists three renames
while the patch fixes four sites, because __setschduler_prio and
__setscheduler_prio are two spellings of the same stale name.

Thanks,
Zhan Xusheng
