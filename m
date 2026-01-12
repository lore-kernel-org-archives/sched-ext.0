Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1502BEFFD
	for <sched-ext@lists.linux.dev>; Mon, 12 Jan 2026 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768254149; cv=none; b=ZGWhDGWV9evUG8xdYATFwEYeNjSDehYzZftD+d7n6/IspVqVWBapZ36U+yt0+wIuVd3XpMoFh1bFTNXY+9wfvudPibfCaD179BBmF4Av7acAZa8mKmcT5uXNmi4oKgha8+NhGWDPiByAJKaVhedyJCJYdrDHA/2uUOiPXXauizg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768254149; c=relaxed/simple;
	bh=GF9+wGqiGYUF0Y1Ew4IhUHLMC5bUwNJkdn8au9M2OfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YdzYYgfGeo8JHBPU7V7lpumdmU5ihB7ss710wcv34Jz7pGbK+9pzt10qr516aipogcwV07T3q97ksdVLOWuiwCELFPn7K/gWmvuyQeVSepXhadC21UB2s3AGQx5IbPAekwSwmbUB1fBdvdB9SMowHq0R+YL8EEy2lLP1ksxetYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=dO4FBf9i; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="dO4FBf9i"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88a2d21427dso69433726d6.3
        for <sched-ext@lists.linux.dev>; Mon, 12 Jan 2026 13:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1768254146; x=1768858946; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9q9Kb0IKWQ2uERfgDT4AW4MYgBHzHDYh9XkWsO3HmRo=;
        b=dO4FBf9iGYwwSvVIoko+Ykt/r/koV28X59Fb/XWF4k8vcD425CNen/HxzY6FuK3DH7
         HuubWtqgIbMg/MBVApifUmkxet5a9dJOhJMKcAv6+p6vj9c3Sx3hwdmFl1brwm8ZvU8+
         MHTKKoiILFJ2ZOjCzL+MjPMQagcJFAv8UeTUoSH8543fA9wXTflppouwMnE9Ogre9pje
         BXAJtyNi/3dyBFeBgDXPihDl4icKCOXVYWZ1SQH8oDMWusDk7K5BdbxUTCXUkV7+S0L4
         rrQ8vO5Q8oJ1dJC/0MYWh1geQ8nemSUOTylunAYju2hmwOI1B43hc5hzFW4Epyw8n7M/
         LKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768254146; x=1768858946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9q9Kb0IKWQ2uERfgDT4AW4MYgBHzHDYh9XkWsO3HmRo=;
        b=ZurDJR9VziQPHzigNWMZNdbgroA8EHzJnE6sEVKpY7HA3VNIT6MjeA218ikeXstVgU
         34fyOdt8nJvghB5bqFQmjD1PkFFNfNS4xXMs/WNjbpNFltNwS2QTS27kMB3iwQQ4CrZx
         MPoB1zIsWZRCb2OjYnrBq2zMbr/U3v4Dct0+3BMSIrF6RbaMsK4OOWpGQw9NWj7qNLaC
         u14XzAmzDVsDi1Z5OA/RR28I4sGi3YIHGJ3CgbXJTWJYDkoxLoFpjADXjbLzYW32oxvF
         C8AnUlON0CYoDCds+a5F9+Occp73fQiAMrHoavoKNSzjdwUnHFRvmx1h3XnQHczhvSVd
         t5Fw==
X-Gm-Message-State: AOJu0YxOergDsOgFfSFcAgfQkNBdoV71eL//pMDbfMjx4lkulbmzZl9C
	gdLX82Jox+qJF+NlSopG68BKQ/xQm2TSNH0GkHpQy6IAer2FySG5gws6clxovZDVBORf3sS5GdW
	HH5Bo+PM=
X-Gm-Gg: AY/fxX44TP+2GOk3ywaF/Yv6Z1dKhvRvUj4vrQUM0F/i8kAy3MeCEe+uvXDnblfzKrt
	FQu3ob7e+A2zUCIumh2bSVa1HI9ox6/My+NBfOOufpyvioF6wRE/BXeJjsc0Qvci6auMDzQNdew
	phWO0Voo0o6jmnJJmBF54SujFRPKVGMpn4PlHgzIeZuK84NUflD7y3dx2pINsYAndM/OfztUNwY
	PuuJO590Wnf/xxYPzwoaKVdqlwdeN6ODcOZHlTdQtPJbx9pbYQyn1fQL/NRFhLA54Zan+tyWV4M
	Jjeem7gb1WNT0daHWMkuJTrJ6xtFoednL2yyFN69bx2Bfyw4xX1uHZXfrzkMPq9oOnkYC/0KtPz
	f1bGMCG795reVHf/kYhNycEMhRSjFG04nI3mSzQFtNkORckHF4nawXKeFceIWLL8xfPdL5qBF6g
	AJMoQ9HrcpOg==
X-Google-Smtp-Source: AGHT+IFDXccF2dF8RNG3rBfuSR32UgtQVBMhmgIeWIh52ubo0ArnGQ7zV8lIRJQINJD3zQWUhS/vug==
X-Received: by 2002:a05:6214:4489:b0:888:84f7:780d with SMTP id 6a1803df08f44-890841a4dcdmr290293716d6.23.1768254146303;
        Mon, 12 Jan 2026 13:42:26 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770d17a3sm143643336d6.9.2026.01.12.13.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 13:42:26 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: sched-ext@lists.linux.dev
Cc: changwoo@igalia.com,
	arighi@nvidia.com,
	tj@kernel.org,
	void@manifault.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 0/4] tools/sched_ext: Add example C schedulers
Date: Mon, 12 Jan 2026 16:41:27 -0500
Message-ID: <20260112214131.50236-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add to the tree several C sched-ext schedulers developed and maintained 
out-of-tree by the sched-ext project over the years. These schedulers 
demonstrate sched-ext's feature set and provide a starting point for 
scheduler development. Place the schedulers together with the existing 
examples in tools/sched_ext.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (4):
  tools/sched_ext: add scx_nest scheduler
  tools/sched_ext: add scx_userland scheduler
  tools/sched_ext: add scx_pair scheduler
  tools/sched_ext: add arena based scheduler

 tools/sched_ext/Makefile               |   2 +-
 tools/sched_ext/scx_nest.bpf.c         | 652 +++++++++++++++++++++++
 tools/sched_ext/scx_nest.c             | 240 +++++++++
 tools/sched_ext/scx_nest.h             |  18 +
 tools/sched_ext/scx_nest_stats_table.h |  20 +
 tools/sched_ext/scx_pair.bpf.c         | 610 +++++++++++++++++++++
 tools/sched_ext/scx_pair.c             | 180 +++++++
 tools/sched_ext/scx_pair.h             |   9 +
 tools/sched_ext/scx_sdt.bpf.c          | 710 +++++++++++++++++++++++++
 tools/sched_ext/scx_sdt.c              | 101 ++++
 tools/sched_ext/scx_sdt.h              | 113 ++++
 tools/sched_ext/scx_userland.bpf.c     | 344 ++++++++++++
 tools/sched_ext/scx_userland.c         | 437 +++++++++++++++
 tools/sched_ext/scx_userland.h         |  17 +
 14 files changed, 3452 insertions(+), 1 deletion(-)
 create mode 100644 tools/sched_ext/scx_nest.bpf.c
 create mode 100644 tools/sched_ext/scx_nest.c
 create mode 100644 tools/sched_ext/scx_nest.h
 create mode 100644 tools/sched_ext/scx_nest_stats_table.h
 create mode 100644 tools/sched_ext/scx_pair.bpf.c
 create mode 100644 tools/sched_ext/scx_pair.c
 create mode 100644 tools/sched_ext/scx_pair.h
 create mode 100644 tools/sched_ext/scx_sdt.bpf.c
 create mode 100644 tools/sched_ext/scx_sdt.c
 create mode 100644 tools/sched_ext/scx_sdt.h
 create mode 100644 tools/sched_ext/scx_userland.bpf.c
 create mode 100644 tools/sched_ext/scx_userland.c
 create mode 100644 tools/sched_ext/scx_userland.h

-- 
2.49.0

