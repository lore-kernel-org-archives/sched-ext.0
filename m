Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13CC257821
	for <sched-ext@lists.linux.dev>; Mon,  9 Mar 2026 04:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773030903; cv=none; b=ZMUlLPth0vaAnflT8OZ5gTq2hB5L/HBL6hwd4efAmyG/iyAVKEKFXkWybJT5g0YJPz0Aov6g6IJx2cDXr68I1g6JOwWSdLfTOirub8xc0s5P2eB/RJtmaJHJoHDM9ikAJd1RlkISP7Ax+abejS74xq6mzOIxmq842ZoCU8Rjx7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773030903; c=relaxed/simple;
	bh=PbYg4Vu4fk3WUFYqeyjz4MfA0qOdQSRvqOGvTne+pqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ch3cr50OSnrMq3NotId/PbaqzoxGAL5Zl6uJyjtDYTEIrLuhqKKhnERI5eh+lXtMPGxoTjyNrUkClRQGU9TonOPAOFxHV5hDIbQNZdEdNpa83pyohYQfMEZE/VsefCiSlBl8ZkrjEcc9vHID9NALOYp57ZETdCoHQOpG/F9PgOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qe7offxC; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe7offxC"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c73ba417c6eso86114a12.3
        for <sched-ext@lists.linux.dev>; Sun, 08 Mar 2026 21:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773030902; x=1773635702; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sce4Gze+9oS9lM31XWXBjlGeGsU+fK+bvB4yoYsnol4=;
        b=Qe7offxCm1WSX4Gk7pTaBhVMeuqETlT2ex/TNfK8wVmWKy3JAjInRVTzGwKISxQ9U0
         q5yvvC2mhRXETYYmClUQo/LbY49bzHh22WlVF1NvKYx/knF69P756/PNakwpnl5H1vFj
         fuFDW2iero+oJQ2Buxi5Mjd2QCxHnXRi2E7MImruF0AovTFBqR9Ryd5Ak9X51aY2qGFz
         iLMVIDg7cW73TVK+5g6wovafnE8vL76I6O1M5f8tkPwxJ7AmsrxWfjndX2vQXWMBBu9/
         Rmh6Nc+NOU3Hq8usetl+2ZZEAU+nXrcklkoMbaG4n4lMnGLJQ9JAMxw+8e8yaNrr8Jed
         WDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773030902; x=1773635702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sce4Gze+9oS9lM31XWXBjlGeGsU+fK+bvB4yoYsnol4=;
        b=Nzmxt613MgOKE+D9QZ9RXcoYfso5tvXXLncInxE27fIPjDGo8hlk2gVx/XmQltVHPP
         rWAWGaKiyOnjTtjlBmbewUrfEKojNNRnHHVmUhMz+trqB4HQckqEz421lTbwKjf4ot9d
         A3iBH5yALjd90jmr6KexagZNpimxUB4B3fxbRh4C/XKAtHt3TnbiG1vemtrOmqUVAWlP
         4DVNk9XfOCfADVot26/WBt3ul1m8IMj1wk0/bzLml69MvlBDWDjUlD1TpMP4Bn0WwUhv
         UiM4Xik/raoreJy5yEHa8GCP804emEe6Z2wF+lfC4jVyONAwSp7JhPsOr7GkPmKIps4G
         DBrA==
X-Gm-Message-State: AOJu0Yz00+kTxfyAWJsYfzqkb6TNWv4FYZWUOAN5VB0M9zisngi2jNXI
	gdhKBoJBS8h5KJmKrECGfzbeAP9xQDocoFzJEEo5gF/R/FI4+B2f6HvsrP2CCg==
X-Gm-Gg: ATEYQzwAYwhDOZb4zu7t0a4CfANf5ycxswerR8Fd9HaFAOEoO5NMUaZP+xrfuXvprhR
	iLfjJgjPZIbMghneVWigfPPzF1yU5n+qD6meTxVjCKhdrQO3w5D5jtW9CV2h1eP8INN0hLcJPU2
	KCXl0vxeYrYYoV+YlrkmZ0AS3mGrdUh2DgiSgHOlG8G0buBknQcVBHFaPFnMISxfhtT7KwrmJqq
	Y6jw5UqLFhYQJpkCA6MJG619Ju09699R/l5Xv0HFu7I1inQGEBG3FDyQl0hkszfSYDI+Z/un+ws
	uMpkXcfeJh1brApBTvIharn2q3R9/8MHJyKLzElnrVTkQ1FjYYEdTkBH97jgXSMJRyNmZR+5ixW
	ktfavhXwsf7wW+1X+fuJ1Pf7silS4gHm4T2lcsJMSBYUL2obnpfUyKB9FFMnozNbK7oWtYXKWsc
	lwkv5YqBp+JLDyBib+ppGak5nbLu4aW/1zRxqiVAXZoszWNU9kPgk72INh2pgbrRrt58iCrfGLG
	JxUyPoewczRtg==
X-Received: by 2002:a05:6a21:4983:b0:398:7357:bb92 with SMTP id adf61e73a8af0-3987357bcecmr4655047637.5.1773030901820;
        Sun, 08 Mar 2026 21:35:01 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e0cb73dsm8122385a12.11.2026.03.08.21.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 21:35:01 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: sched-ext@lists.linux.dev
Cc: zhidao su <suzhidao@xiaomi.com>,
	linux-kernel@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	peterz@infradead.org,
	mingo@redhat.com
Subject: Re: [PATCH v3] sched_ext: Use WRITE_ONCE() for the write side of scx_enable helper pointer
Date: Mon,  9 Mar 2026 12:34:56 +0800
Message-ID: <20260309123456.followup-kcsan-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309024612.530874-1-suzhidao@xiaomi.com>
References: <20260306105901.2543743-1-suzhidao@xiaomi.com> <20260306141718.2721073-1-suzhidao@xiaomi.com> <20260309024612.530874-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Tested v3 on a KCSAN-enabled kernel (CONFIG_KCSAN=y, non-strict mode)
built from this tree and booted via virtme-ng:

  Kernel: 7.0.0-rc2
  CPUs: 4 (QEMU/KVM)
  Memory: 4G

All 28 sched_ext selftests pass:

  PASSED:  28
  SKIPPED: 0
  FAILED:  0

No KCSAN reports related to the scx_enable helper pointer were
observed during the test run.

The fix (staging kthread_run_worker() result in a local variable and
only calling WRITE_ONCE(helper, w) after confirming validity) correctly
closes the window where a concurrent lockless reader could observe an
ERR pointer via READ_ONCE(helper).

zhidao su
