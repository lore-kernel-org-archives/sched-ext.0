Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0D713777E
	for <sched-ext@lists.linux.dev>; Sat, 21 Feb 2026 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771678591; cv=none; b=KR2K6Rh5phoxLHYDpXOUUcHFtryfdBsTLf0NzX6sDmyuXCEQAyYttp2OHNz4jYhfuqiJm64j0REW7s9/ajhTbSqqFEj2RbzryAtBV4yIaHV8s7GmVm/kYNn61hDrmtvyE6v+KWQcEsE7icbyjqT4F2fKqP4dDcOJOptEorYtCUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771678591; c=relaxed/simple;
	bh=ZMUYBp0xIbBKwd+aUjYYHmBTirKSy9Yy9ksuBCyvrHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a/56osnm9cfQiuMTlnJKyfwGZGAG21pcFm/qRf0nQuTwQvyDQVTwxE5SIHsgP814EajUNiZQ0xJjqlRHFJvLY1VMAH3wmUgJG4P03C2j5/ILIoiKPuVgFLyk4RINnHfXLorD8hDMermi8htW7mZTglS3rgpQ3IQ1pAXeHqUPjG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bb3vsEs1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb3vsEs1"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ab47d8b33cso16086575ad.2
        for <sched-ext@lists.linux.dev>; Sat, 21 Feb 2026 04:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771678589; x=1772283389; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v2ESwh1kNSMzqmH/CNnLqZ2n+nxtVMxH6cX6i3cdBuk=;
        b=Bb3vsEs1/1yPffoj+HcM4XwLvCZ7h+G3tXvPpNsnU4ymODnStRaWJTwSy+sPWFGuFU
         kc4LDTsnMTFb2ogz5qwjZwgXJWgnQIYxIiCxlyiJywvvP3m29hUIcJKqYn/6Kx8XmlUW
         HgbWusiLB/yvPlyWB1e52uVS6FDydYsW/rXCEt01+qBJJ9R1u7MukJDq3yPKS5BxA7gj
         qWkqr14J1pTbrvvhibQKHn9W1U0xG8FV4R0rNgt8MkYeTvj48bSjWuY5LQG40yUr5psD
         PAtyVQ4kP9wJsEkf83ze7efjxC0kKmLZ2hKM2Rp6TAyZaDpCGOXIpNMLn8vuGTqnbrKW
         KF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771678589; x=1772283389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2ESwh1kNSMzqmH/CNnLqZ2n+nxtVMxH6cX6i3cdBuk=;
        b=CC2crmyyFVScalFONDzjugxKzqnv7T5kyZuV6FkNbszwDOI0c/uNSPD0xuHIXWoAjW
         p+e0Hvp1RrS6NfekuX+YrqXWixXv5tr7SBRXWmpaQWPe3fxpTsoq2StrVQ/fnFQHtARc
         t09dmpkz+JwVwU9dqmGLC7yNzCXHQJFFVr8rCWZjC0c1ojew4IgwzSxRcZDF3Ws5v9ot
         QLwP5hr3wIfNOOWIbCx+4ihUXzhM/Cso+e19L274LsfRH8S5yNWekm9923rrkQ2ibaq5
         ypjEw/YVqGnz9rNHcVXLLooF+tAFHSIjFuKpD6SXd1jaUhcDzKXJeyVlzD1lWCSt0ppz
         4F6w==
X-Gm-Message-State: AOJu0YzRYDaBoEcHOd+i5SQQf+dLFO1uE2cP0GO4EY5UXkMptPtDJi3g
	32NnKKuq/HUCp4KXBMKLXG/YrOh1/aOTK8OISeuNEzTIIbPMLnNwUWhvCUJiug==
X-Gm-Gg: AZuq6aLlvZj7O25OqeMwRAtSuvj84VjTKT4rA4Gt+uf+79YNma4xcmbdaTOZz5mVQQi
	gIM8NtrwZz5GCI00JZCsA+C+N/BjE7B9MAm7TATgln8SLgaxo8ZUYsHrMevb1iXWNmvMia0zBxH
	TlBOFh2raSMJNrTJmohu723er+zoYnJ6kYxH9b0IG86Can+8zokFwDA9xHn0tGVmurEaJ4RKpZi
	Ho/q4TAUkx91Pa9Ccd3WCIIJkdmb5GzYJMcVp0qCd0h8QZEDsOroraZ+sQDbh8ukRSP/iFLoefr
	sszBPsTImvBkbppyzk83XLQ2t0CnJB4Qidmobko0tQ/mRNWnaxXQhFaqiMiZXOqgdqaffKEFTZK
	nV4ruLA4JPU3lidrFTuqXPhKTKB1woQ8Ui5tePvooBRW6H6inDGPASqax4oOEjK/rae/kb2SBjF
	wvj2FJeb8SXmf4xr2hhXxC30PMR0we9HCJhER4jmZG5UjjJNe0Nw==
X-Received: by 2002:a17:902:d2cb:b0:2aa:e568:164a with SMTP id d9443c01a7336-2ad7453de73mr28432935ad.31.1771678589246;
        Sat, 21 Feb 2026 04:56:29 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:4f:a1e9:3b8c:51c9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7500e29asm20742195ad.44.2026.02.21.04.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 04:56:28 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 0/1] selftests/sched_ext: Fix unused-result warning for read()
Date: Sat, 21 Feb 2026 20:56:13 +0800
Message-ID: <20260221125615.1119571-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The build fails under -Werror because read() ignores its return
value, triggering a warn_unused_result compiler error:

init_enable_count.c: In function ‘run_test’:
init_enable_count.c:60:25: error: ignoring return value of ‘read’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
   60 |                         read(pipe_fds[0], &buf, 1);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as error

Check the return value of read() to satisfy the compiler and
catch unexpected pipe failures.

Thanks,
cheng-yang

---

Cheng-Yang Chou (1):
  selftests/sched_ext: Fix unused-result warning for read()

 tools/testing/selftests/sched_ext/init_enable_count.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.48.1

