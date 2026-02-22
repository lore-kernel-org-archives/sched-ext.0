Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD0A1EB5F8
	for <sched-ext@lists.linux.dev>; Sun, 22 Feb 2026 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771765716; cv=none; b=jzUSxA6vZBMdxRlaGz1KelcTcjcP0cgo9t0CcshAZ8xhUpXMKycS6jAMN545Q7AxlwQhvjwqoWrFjmGeo89evTCQGIY2wAChngkWn8G3GRkJpMvpOXQIR0XrWxRsdeTwS95RKkL+A58pXajQ+UcJ021awnzqZ8raSvx0j7m1fuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771765716; c=relaxed/simple;
	bh=+UKKUdD2yH4ITBMHlAeyK+T/+RXvAV7v/Xy7fkUX7YM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pc5PH8KL9oU4msrWEmrLjFkoh6L3CLCQjyksQabapCUFxQuR9DXdjuU1VcWnIUtFNJQmzEYKB+mL4OsuRehx0U8INAZbM2EfbvJG8f/XfHoiV0aGre6hPv3CQoTwZv7qxhhbnVxisRDKjAQ7+/5djcRAsoflOtDEK3knUc8ZKNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsVL8cqc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsVL8cqc"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a962230847so34528705ad.3
        for <sched-ext@lists.linux.dev>; Sun, 22 Feb 2026 05:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771765714; x=1772370514; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EJwgf6pAFmLAjRyy6iJPt9pz1tnjfmh7sAoPdvP/EFE=;
        b=PsVL8cqc4u+GUDzfV0gc6eQEso6cMQITK4/d2zyBtEFPh0IbFmheDiO1gIip+HPjkO
         vaVcnUPpca/RublmIMtrzYiESU+Ha4Pf55z7h/hcj3nXNTtkGgjYqlhmHiOsEciZ/z+U
         39lUi4zhkz/DyOCMwI5qKlfu9LGGAJ4vILuSNwNW1cMPDN/GtuJtWsUo4Xsca4cLDwZ2
         Etynq9khxhyLLK0aXE1kSCRUhmHMga3GKGRTQ2Vr5myXTKXVGkYyMfIpAodhCes02SI6
         d3jWXUwaI/xXX6i9DEa1QpnWeL34wMOcoiNnsD+obDRi61elDs78bskRjg9++IktzMfJ
         Y4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771765714; x=1772370514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJwgf6pAFmLAjRyy6iJPt9pz1tnjfmh7sAoPdvP/EFE=;
        b=n+wJVo41fpK5/MQCPCZQYA6cWs4Cj61B/MmSbE8dstGDCONljavlLPdxUfi0zoqZSW
         y1/qM7t7Geoh2gVkGI4rQTB1h/wI/xpUIYXdnDOWiyqf8bPIu8oX3iyMXVrbaznKIB0b
         gRuo+lCzygaKs0GgUffDAI4fOL0sJZJUGl1iIGVXj1q4mXNpRtcdba2WR3EeKLI9DBlc
         Ry2k6jlZWSPgTCFd1sStjimziNbzh1it4H8iJueH0OUbdNNmisZNLoDd0RZ6Kdzk/UaV
         wR1SwFyvvq/L1MM0P3SA+vWpCk+oMfmF2Dam+4HUs7M+lNEmU9BY/Lv4GAj3uAEo1RVu
         XfUw==
X-Gm-Message-State: AOJu0YzcZNVOTwwzgjG6YTtpstjSQi1alUdj9G0v9sGlUmW6uyFnH/+e
	VmngUXdcSP6dtfPpYAVx4CqndPEy/iR4r0KDgZFD4l5YqhtNvgWsKeWzekXLyA==
X-Gm-Gg: AZuq6aIUUw+9mou67TnLqVm7LbSeVC7xatdmLUH515vDTUENYieeCBOEC4m/TfbDsUm
	Nwlbe36klRHZRqDxyXlHjDRtIcq78jwJwGpFzecfTglmC41/34VjbzEQXEsIA/w99y4O6Ev15n4
	lXhH/a5fv9hp6Tf0cQeUbYIKvT5zTBt0sEURNrZs1NRAs6L99SHF2SKenY+JqC4oJ5vCOkm3Kv7
	e97skGTUvVdA9Eqo7xKCf6ld2E7WG4mdHFH4W7+yizPmv3GJxmEUxSZVGr4uwFI2lS5iTpdku3a
	u6vuo7kehoM2Pg3mSt9o2iHY9G0t/gGsHr/USp45QkBFwgKYvDvjiGkH758u/Mqe9+oaNzW4hJ+
	yMGZKPutNtA8d4jtrQTXtrY/qr0nRJkSONzUi8kScXig1AozrczgVxBbdQ2X9ymu0fir14MjdHc
	WAqmeutluJWZ0P+q5A0QubBDsQ7Sq62XYW4oDRu7npjsGb0D+WDcuO
X-Received: by 2002:a17:903:32c7:b0:2aa:d320:e969 with SMTP id d9443c01a7336-2ad743fb337mr55485665ad.8.1771765714282;
        Sun, 22 Feb 2026 05:08:34 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:f3c7:b896:5ac6:4be6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad75027b0asm48433865ad.67.2026.02.22.05.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 05:08:34 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 0/2] tools/sched_ext: Clean up unused getopt flags
Date: Sun, 22 Feb 2026 21:08:24 +0800
Message-ID: <20260222130826.37085-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series removes unused option characters from the getopt() strings 
in scx_central and scx_sdt. 

These flags ('-p' and '-f' respectively) were defined in the optstring 
but not implemented in the switch logic or documented in the help text. 
Removing them ensures consistency and prevents user confusion when 
providing these invalid arguments.

Thanks,
cheng-yang

---

Cheng-Yang Chou (2):
  tools/sched_ext: scx_central: Remove unused '-p' option
  tools/sched_ext: scx_sdt: Remove unused '-f' option

 tools/sched_ext/scx_central.c | 2 +-
 tools/sched_ext/scx_sdt.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.48.1

