Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE231D6DA9
	for <sched-ext@lists.linux.dev>; Fri,  1 May 2026 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777641391; cv=none; b=gS9xbo6mJe8DT8Bo9aZaresuDJuOnWgl+IsEG0SAsXMsJseG/yjoht1fCTSaSu6VejsRcezbYuEri/ixWTyz3ZXjjyPhJl+yXkIIuLbvu0TE1V4HB0P5IB/wsmkHRsGxUfzN/fY60y4yaWUqECQlc7BKxAbqIz9iDPjol8btxlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777641391; c=relaxed/simple;
	bh=+41dixGNeuD2dVMUdxAXfx15jbMsmmmXJdlPS6imaks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=joH074Fe1TE6H9UNwBtjQ9SpBaOxgupbD7sY2EUQDxQ0Fr0/kUWG/CPXoKVHnOE2upayKhQC4242QrNq1z10DJ87UkMMP+vdGOs6tHJxBvBJzSSkGNLKEU5aCYfJziidRApSugGadeVBvkBfx0/yQ/jemYcJ3kkYBuA6yT/rhOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pBSE3u7L; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBSE3u7L"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b458ca2296so11696235ad.0
        for <sched-ext@lists.linux.dev>; Fri, 01 May 2026 06:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777641389; x=1778246189; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IVOgkFgOSAS8LAKhbBot9eAfbt7830iNQpu7KWGXDJs=;
        b=pBSE3u7LvQN8v0f3xUZIRpmiUiutMfQO3K/HE7mG0tKCB2WVHeJCYh80mAWGLErmkP
         F2hljaEnBnbGkGNeOap2aA2HU85FYTsJfXF8/N/e/8rv7P60LxO+LNQQJnMap9DKNHoW
         nnvLqI+1e6r2jFr2Z/c+vk5+/j/l0TB1K7mTBH2ulQ5BsvlVfmLCD0NrJK2YbrzS6wBv
         /WzD9YvcBxqBfelroDP/g3vweLvUezkzxde5sHCqmdAmuQJENtRkMpDsV7NIZC2hpHAS
         ywlQ+A/1NpVf8Oq4RE+vntmFDDlv4TGy1L/tKsk4qrHeDCLhmVOk9oS7rWh+fYbVh4q4
         I6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777641389; x=1778246189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVOgkFgOSAS8LAKhbBot9eAfbt7830iNQpu7KWGXDJs=;
        b=s9MgIoP3nsljsD6H65sFcjFVGBrNHIIW8GRo9PipUgmibt5VI1WoKihEgHP61zXu+C
         iHCAzc/Ix2RFV0i2gOg8mY+TgAbZNv7P1YLOM5M/+sgTRXXxjxKxR/OEArlMTn0D33kh
         TijDID/2rUpbYAFsd1TujnIGW0EnpyeSlxtkR34b1fTe2us9L/bLzBIR4HCaw5pnDGuI
         UkqCtw997Cxx1SxQTkQEaYH/TJ6HZ87NR6pkjvREwgcGppzfVV2STbMfQ8hs7RvLZ2i5
         BFQMAeKYC1oXFxsme78//Afu+Qn91s/W28/fva6BJCQQ9Ie8AN63gnNGUd5z4ndjiGOy
         nSwQ==
X-Gm-Message-State: AOJu0Yx9J3+mTwD3cHMqS3mJdBe2wCHdAUpzyMhKryZpmdPf/+mXQhcD
	LRvucpBcu1o9r0dubisYX/DMXSQouok7+v63ejoTJ8A8Ilhnif3uMix/hwcFqw==
X-Gm-Gg: AeBDieuxyLayxMBxnoTxVIlN9E1PeEjFf4+c/COGvEJPrfRhWfY3n/uzPrEvsukvuYK
	AVWf1KbSAR6MWIB4LUoxYeMVPP4RT0WokmbvCprQZ04Fp5wrAcBc09hNXGaqH9NecrF8vYOfv9T
	bpNU2gzIb7p4Rhl5HnVyoa+eLxBiFUKdQ1JXa7l4x86s3+z7vp0zVxRp3jkX3ONtCU/yS8XiN1m
	5DL0WPdmZWjuRZ4MT4o6U+lvw9ZbjhfWSMgETddr+PfNV3avrTrJC9UHZVHnzZjq0xu5sYMQ7EW
	MmOaq89tZboOEODpoR6Zl5WjJeg+fLUWj0xqWPYB64Os0aUjmlATaXFHi1oeRu310Wq6pFll/qB
	Q6j2gT42O2RiZv/FCE1gEsB7qnI1XLrhieHjJ+cfuruWCTocfx0fkC05vtU6DEy2Hrol5gilKlP
	+sdCUNlByCMZyTHV6ovhk1TEkxgF/MlfpmBkahl8P3xu7uXqNjvBvIz2O18/v3AeU=
X-Received: by 2002:a17:902:c209:b0:2b0:c45a:bc2 with SMTP id d9443c01a7336-2b9a2354024mr50552755ad.16.1777641389309;
        Fri, 01 May 2026 06:16:29 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:57df:16f5:b7ab:5d05])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae59f62sm22438005ad.70.2026.05.01.06.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 06:16:28 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH sched_ext/for-7.2 0/2] sched_ext: Follow-up fixes for exit_cpu accuracy
Date: Fri,  1 May 2026 21:14:55 +0800
Message-ID: <20260501131521.161852-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow-up of Tejun's suggestion [1]:

Patch 1: Normalize "on cpu N" -> "on CPU N" in the exit dump header to
match UEI output style.

Patch 2: Fix exit_cpu accuracy for the hard lockup and RCU stall paths
which were recording the detector CPU instead of the actual hung/stalled
CPU. Touches kernel/rcu/tree_stall.h and kernel/rcu/tree_exp.h to thread
the stalled CPU through panic_on_rcu_stall().

Based on sched_ext/for-7.2 (88588854c283).

[1]: https://lore.kernel.org/r/e7cbfc99b52b4b7059267bb81498179f@kernel.org/

Thanks,
Cheng-Yang

---

Cheng-Yang Chou (2):
  sched_ext: Normalize exit dump header to "on CPU N"
  sched_ext: Fix exit_cpu accuracy for lockup paths

 include/linux/sched/ext.h   |  4 ++--
 kernel/rcu/tree_exp.h       |  2 +-
 kernel/rcu/tree_stall.h     | 11 +++++++----
 kernel/sched/ext.c          | 15 ++++++++-------
 kernel/sched/ext_internal.h |  2 --
 5 files changed, 18 insertions(+), 16 deletions(-)

--
2.48.1


