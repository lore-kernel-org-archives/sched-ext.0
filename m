Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5817134BA22
	for <sched-ext@lists.linux.dev>; Tue, 13 Jan 2026 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322905; cv=none; b=gegpFu3KV0u7PbXsH7p3VhDkog7/J/HfJ0ShnaxHpMGZpV4VxMH5iJN2DgOuf6jtruBYGcnaM+2/FtSCFK/fpfxH4cvC6D2o5WKNBh6DAv/AR6LzApTFTa9wAikyn3Je8brvjjjL9nUXLmJMN6CH4GlBjLY8Xd2yUqPrYVZ9WCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322905; c=relaxed/simple;
	bh=3CDHirVu1VPzms3qo7El1UQomYo0e9qaVDQitOgU1cA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VALcdXRxUcvuSp61wtfDwXuZH2r2DMtX5cIp7i+FIkttx3U1weJ9a4BVtCx9+ZZQCeNK95Iy9MhQ4EsulcEDNJZ6VRBZeu78BH5sI87hFgGcUWegPu2qNOCjiXdn5Cs584vXuY5bb/2xW1w/AWOfW8oG/njiQ0wbN5qQl8229ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=pa79ZjQy; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="pa79ZjQy"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c2f74ffd81so804954985a.1
        for <sched-ext@lists.linux.dev>; Tue, 13 Jan 2026 08:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1768322903; x=1768927703; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GiVy2FkteBXRkI4xU2VoW5TqGYivmjc20LJucjmYc3k=;
        b=pa79ZjQyRz++iwdqDo/bWI6I9oynMunAWu2qUIiB0v44QC36NUxipEWxKae5aegaoj
         5d1Ac/NYOOo5d0fZ17Rk4OpX9lvHj79xplIU8pHRvIvGzzbYOURA8J2sfe7uzu8x6YWV
         s4Z1nNu7pYImTSTKjpz/N48XFCEprMtu0g9SoBx1C6g07Jl+zfr0+pB4QE3csKDCRufd
         k4Z5+eeKTqDA9Z7oWAHnIvJSlQG8IG74oNTiC5+Q1tMFfBBAJXh3cn5N5zW3L+4gEnl/
         1f1B9mUWS8wfq3argGB51Z71lhF4fJXg/czpU7AEBFgsTOmhsggGdX5hge7QNT4mUS4L
         QWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768322903; x=1768927703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiVy2FkteBXRkI4xU2VoW5TqGYivmjc20LJucjmYc3k=;
        b=IEk962QhIdpcu0nZ5afKiYfSof3raYIo79WIISisxiL/MkNGHzOsqKm89bp6r8zqtd
         B+sBeC7gFeP9TxK/5yk6NeBS69ysAQxTuecFGuVSDrgrzydf63scg4HSHmolhmYzy7Fs
         H2L8SKJTXU/9SwNiAwfkd8T4FRd9Q8hdzYt/kTRaOoHAj2KES2IyjVd0ncRK++LBemfI
         IDxwI2NlV0FvskP4yLpBDM08WXFjzLcjOpkfDeEzgna4XlwB2WfQsji6axqgnJnkedS8
         Pk48oU7CTq6EanttNECHELfDj0M85PBxUpPq1wR1t//TwY/2eD2oT33orkUllUhOBpO1
         YujA==
X-Gm-Message-State: AOJu0Yw6WYKm6NVvIDxrqU3/hwqbfmMPaoOagGTxJTID9mhmyV2SvJxL
	z8wz5knetvxI9Gmymt6yzq7qwBmNzNC7mKC3Ruoa5nWFc+TK7SRCOM4UoAOs6tKCXgXbQ+38G7+
	orZbZUe0=
X-Gm-Gg: AY/fxX7W9oVA1YUbMqbfG+/VAVpjmCMwC2SfjhVtEhIPzZUuMb2gGgo85+BIov2OSMh
	33j9zZHHzYT4ppwDLRlBIM974M1LxtooAESXfOlXz6WZDb6lHKJv/ui6H008M3TVX1ebaNOgSLm
	my8ChB3zm4T2bS4x3j2ofuzQpJbd1Pi4sP4KcCtKQxmfO9YWRk0Htgudd1Px5NRfqhtZh6PbNvj
	HrhW4/jBCBexMKZi4e8fvxryjtD+mM3RuFFTvkTaENCU6O7JAAq8AUib6rFrADMYbFZYufhpOY7
	BF8ohlA5FwIM40Se2T+XGfQo93EyauNVeTq4e/kGcNsPAXKrgxq6ZP8OlzRLGSu9lr0SNjmzZau
	hXIorV5e5H274Pg7sWAvv3ZNAr+R8K6yGqvqIo929nzNmgEY9F1ymNWiXoy+EFfJn+BITUPoH/Q
	z893hqzIN8Ww==
X-Google-Smtp-Source: AGHT+IEjmdyOR+D9TnjLyE641pjnCMlJhV8T9USyJl3Iq7Dj1fWEQtz+SlolXzK4QPTPSKEedPstOQ==
X-Received: by 2002:a05:620a:4541:b0:8b2:d256:d05b with SMTP id af79cd13be357-8c3893840bcmr3178172385a.20.1768322903119;
        Tue, 13 Jan 2026 08:48:23 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a8956sm1690928085a.10.2026.01.13.08.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 08:48:22 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: sched-ext@lists.linux.dev
Cc: changwoo@igalia.com,
	arighi@nvidia.com,
	tj@kernel.org,
	void@manifault.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v2 0/3] tools/sched_ext: Add example C schedulers
Date: Tue, 13 Jan 2026 11:48:15 -0500
Message-ID: <20260113164818.14305-1-emil@etsalapatis.com>
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

Emil Tsalapatis (3):
  tools/sched_ext: add scx_userland scheduler
  tools/sched_ext: add scx_pair scheduler
  tools/sched_ext: add arena based scheduler

 tools/sched_ext/Makefile           |   2 +-
 tools/sched_ext/scx_pair.bpf.c     | 610 +++++++++++++++++++++++++
 tools/sched_ext/scx_pair.c         | 180 ++++++++
 tools/sched_ext/scx_pair.h         |   9 +
 tools/sched_ext/scx_sdt.bpf.c      | 710 +++++++++++++++++++++++++++++
 tools/sched_ext/scx_sdt.c          | 101 ++++
 tools/sched_ext/scx_sdt.h          | 113 +++++
 tools/sched_ext/scx_userland.bpf.c | 344 ++++++++++++++
 tools/sched_ext/scx_userland.c     | 437 ++++++++++++++++++
 tools/sched_ext/scx_userland.h     |  17 +
 10 files changed, 2522 insertions(+), 1 deletion(-)
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

