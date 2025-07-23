Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7D715A87C
	for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272476; cv=none; b=UYPpQPquMYdocktC0hDhBV8vp+7rrt4856/FM3+nteGsZ/38SXzZTWabbsRKM7SI8fyl6IsPmo0xf0kD2HEMD1T/hxZUJpvOHlFyDVxuCZrQAejcgfTz5j/w6uwdTfvSnkxlUWF2Fy/za/DbLbSWPhhntCzNFU9r2AfrnV2n5A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272476; c=relaxed/simple;
	bh=qXJJEfEsKPVaVI4rrIuGMmIuESSIUwXoLud31X8e2c0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R77kdIOLKTDqfo9fdIrDSs9LcmgNn/MxocgelCr9clc44yPCwZyhGETulL9Ac4jaALhm4pGhmEL3l7lN2RtrjF2S/FrprxdJIasbwfJ/+oxCAiXfabPjY9UUMjwKjJ7/uB63ol6+2hMOwzagQj6fWi6NY7TY6VrDloMEPBQBGTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJIy3+9+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJIy3+9+"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748d982e92cso4389727b3a.1
        for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 05:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753272474; x=1753877274; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ABo4i8zediInvH6c8NXAWBBwAdPVLCLpWRiauHT/q0A=;
        b=jJIy3+9+UBCWRIrmNYtm8KOt4wuRgRoyewAbQU+XyfIe2sz+afgLXEoFPIaSwkK1jW
         JMijnHTS1UtkKpmn4mh3F4ju8ILq78fjJyb5WI61Fwx4Hwz5ZOcL++dsQk3Oyp4mgOh3
         lhiGx7xSqFn6BqPWFK02CnkEsXsWZPxLAsfgFm8rm7NjkVIG7EHi4Tv5YELGboorOP6n
         FjW2jETl9jbAyayFUJEV0nNikHwktXJ1hlldLL6sIzHjGWFwWBbLAsugeXtNkmbEsrlx
         U11tIMr9Jz/SYlvigNpS7Is0V+0jN9NNE0J9yCl1Qnlg6ZS4ZWa3BNca3CYkr4MFypLm
         hu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753272474; x=1753877274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ABo4i8zediInvH6c8NXAWBBwAdPVLCLpWRiauHT/q0A=;
        b=hwiIIagmGaybMLIhaOUhtyLe9eWx/492tRzkRx8bvA5+2Xs3zJrhgpCjguQaCR7Ame
         ZnbZLFyF0CNGMZ1sMCbgthFQokGsOdeigpNqnpGYpcT8jRKwZyS3L9+YSmfwFWw0zc28
         guXgvpsBbV/oJ/MDEqMnMq5yc3Ob/WwCE6tv2ceYE/4s3jk+J1VOZ+q1SYZlzXUD0KUM
         MNm1GP3jR2RGPvyd8Z1YHkBc78aXg6+7esFXZh2UHRkTIx9k2IWUMJD7tUCZXpS48Bst
         cxHGhqWPOS0rr6I/4+EkyHhnsVEvFwxdgmMHWcEkyIpefWC98ju2WlByKT2Mk6QWici0
         Dqbw==
X-Gm-Message-State: AOJu0Yzbu0MYY8d/EbYtgU+LloBQgxIyPyfcn0IGkJ7aBRyChuwq4jW9
	NkiHEIwH5a7nlyliKnWtszy64sTxLAd3PBCWHMGuP2sFLOjEW8KjoIzqnA9kh6TmOO8=
X-Gm-Gg: ASbGncuUh3WRKt6PxGSAgESRLsBKfWl9bZ13veC90eEoQD+hNxPurumzRD/pQJAyZrD
	mq/0GnpQw9IzrZbFbhyBdzmnB7aaq61/0asTmCosGuhd5MgpyLAXvS3MD7aQ0kyJw8B6mi9Sgjv
	WGMOt3d/EyyIZf548wKr5nIWZ71ZIVBR/oYox0QB0VslXdSdeB0URJGuCkLhb2qQHgm6zTVryu2
	HCFDAbnsX5kSYcYx8YtEhsKXy0bYxrryvIa5FKqtsDjsrNLSroe0CfDHqqXQT3YpIdD73GFmdOI
	5G+dUiP8nwb+agipm6trxz/m8ISznQpuyRTrF8FHy28R6FnL9iLPGk9zK7Bpt+f9bFjEu0MRKdc
	6paTyHVuAEf8XHV5mGsgOMa9j6TI9lk2Gyvkw29rugoZ8iSOMp1id
X-Google-Smtp-Source: AGHT+IENnPdHDea/zplmIvNr0vozGTx2bXWWPMg0pvUsuJy9dl+Pcyd4vDI/oFK+EC2sjKLEYn9ibg==
X-Received: by 2002:a05:6a00:9a2:b0:736:a8db:93bb with SMTP id d2e1a72fcca58-76034c0526cmr3902369b3a.5.1753272473439;
        Wed, 23 Jul 2025 05:07:53 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:b3f7:1e17:c773:7c18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb1569e7sm9589040b3a.90.2025.07.23.05.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 05:07:53 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 00/10] sched_ext: Sync with scx upstream
Date: Wed, 23 Jul 2025 20:07:36 +0800
Message-ID: <20250723120746.52847-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series syncs 10 sched_ext source/header files with the latest scx
upstream via:

	./sync-to-kernel.sh /path/to/kernel/tree

The updates ensure alignment with upstream development. Build tested
with `make -j`.

Thanks.

-chengyang

---

Cheng-Yang Chou (10):
  sched_ext: Sync with scx upstream in tools/sched_ext/scx_central.bpf.c
  sched_ext: Sync with scx upstream in tools/sched_ext/scx_central.c
  sched_ext: Sync with scx upstream in tools/sched_ext/scx_flatcg.bpf.c
  sched_ext: Sync with scx upstream in tools/sched_ext/scx_flatcg.c
  sched_ext: Sync with scx upstream in tools/sched_ext/scx_qmap.bpf.c
  sched_ext: Sync with scx upstream in tools/sched_ext/scx_simple.c
  sched_ext: Sync with scx upstream in
    tools/sched_ext/include/scx/common.bpf.h
  sched_ext: Sync with scx upstream in
    tools/sched_ext/include/scx/common.h
  sched_ext: Sync with scx upstream in
    tools/sched_ext/include/scx/compat.bpf.h
  sched_ext: Sync with scx upstream in
    tools/sched_ext/include/scx/user_exit_info.h

 tools/sched_ext/include/scx/common.bpf.h     | 102 +++++++++++++++++--
 tools/sched_ext/include/scx/common.h         |   5 +-
 tools/sched_ext/include/scx/compat.bpf.h     |   5 +
 tools/sched_ext/include/scx/user_exit_info.h |  49 +--------
 tools/sched_ext/scx_central.bpf.c            |   2 +-
 tools/sched_ext/scx_central.c                |   1 +
 tools/sched_ext/scx_flatcg.bpf.c             |   2 +-
 tools/sched_ext/scx_flatcg.c                 |   2 +
 tools/sched_ext/scx_qmap.bpf.c               |  23 -----
 tools/sched_ext/scx_simple.c                 |   2 +
 10 files changed, 110 insertions(+), 83 deletions(-)

-- 
2.48.1

