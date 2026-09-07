Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC42F39060A
	for <sched-ext@lists.linux.dev>; Mon,  7 Sep 2026 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763792; cv=none; b=OhgYtjn4A6k4oAgPN+KvgEksme+EkN968kVntZnDoHa6TMbfArkKiL3AKPkV7gXpvZiOsQ6rhcRLwN/Fwby4NhYFxvTowHjJzl96aBzHwveedU6T+CgWIIzCggVso89d03CANT/GRmcWFLdFPhTE5A6tzHbXV5VVObFEtF3gHUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763792; c=relaxed/simple;
	bh=2766B3eMmFd/OaLBWXRn8QBlE+XKdud9wFfOhEigG4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YUEGbBvZC9zd3qX40CBRuDH+st8NVqF96XdgKcXfQi0KCB/JKhYq9qvT114gbuu9hWxvtaj519Va5p3lzqeZooLQxDK/tPoEkSw0l7hbdUDxr2fW+AddFTlV687ieehK00pwfmsExTF0T736h+c5Yc+gIPkH9mFnn54LZnMSW0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUZNRo12; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUZNRo12"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1cbb64a1fso3081391a12.1
        for <sched-ext@lists.linux.dev>; Sun, 06 Sep 2026 23:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763791; x=1789368591; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NbyN7tVnWnxYp0pp4uHeU72ENpo3XFInJUk6Uv6k4kM=;
        b=JUZNRo12CMqe7MXdihVDfB9M95bar6JdEowz7eplCikQhU/QvOIlrOj8V3QRUSJpPI
         xlLD2pnhtTYr2jBnoc6qebQkf72lWRjgAv9MqvG8Pgm4S8dabbeAMRrQCpoxqBpmhvGW
         98NeFsy5f3XN08t2hvyGQdFuUJU+v8QDcjwUz75QnX8t0SJg8BPGDwMyX4Ug8YdAu/fI
         Vf6kszPUJHG7kCCE4c8GO9LfGrZTuV0FkLKc1Exk551pKpD9kwGRT8TzqCUbt6v4ozbm
         py8vOIRhkCHZ0yT9kj3CcnUyMzm0ZlH2dkxakypf6hwafSC100aWNtk7vuArvP0W0g4l
         6aQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763791; x=1789368591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NbyN7tVnWnxYp0pp4uHeU72ENpo3XFInJUk6Uv6k4kM=;
        b=bKdIMkkqWBC/bKh1Z2QftBLmVGSeujK74ZrT08xm3VrOZT4TGStr+mJ8qQ6lYhPpYQ
         hOpX9ZndK5yFcWkyVsSir3uIQyQp4zjrojSmXJLuaB2pn9htjG3DWSMY9L+Wgs8J7iAM
         RNnGy30Y5D36fDUp3TaGaQ+dF5innMoFRFSSauoDbl6l6B5haPwVK6wai/2G99fVgrvc
         IO9ZCj9j/IteFDbeQ+PdND1cbP8DNcdTDrALir4BM4kp1LOBRcYQx3FwYNR/7JjOg3Bz
         n5M7+pRVwrJbdURa4RxxojZB2oFaw4AJ8ZPDQyLXa1tI5tCjgOOf/bFD2NpBVv9tG3vk
         +XDw==
X-Gm-Message-State: AFuF++mOdIuiLiq3RM86ZQBtc+5mkMnLkbuy+ORtFDWxgOj/LD3sfErK
	rmJ8F71oh+yLJD5b3V3b6M+ssi14mIgd+71+1ifv6a8cMKFW4RQSYGNE
X-Gm-Gg: AYBFou2pV7mRWXX0/YW7WXHB5gvpyuuuOPVg+AoFBMxJ4Y9KCWMrBjk3mfFKo9cR1W1
	XxxdERyq3KXkG2rB1tzN9ADEJ/HnKlA7XE8X+w5w5DOYKjTuCUAXH9BnlOcdUMDHq8tV/jO5Ncd
	gDwMXTpsxb5oUN4QRPj2A3+dG75+ho4z3rHXtJNb+Ysa/dgVtVz2/DA3P24sIuF3wtyuXfmfSh3
	Cpswum27GsvFwzO13nxXJUchh57NO4/Ne2VUUcy6wG62ThgjuboPBFhCuiOoDNvLzEy+gbz33eR
	9uyrwg6uKKpFwlrzKSL9tC2kgTe4o2JA9htug670mivcb5TJJT76NqRBjM7j8Kk4dFV/d1mntSb
	FjT8aFEULTaLPFCfpg3XNfyPCIr+l+lEcbc6uO8CUfNUyjN/AYK25alq8zkIgFdl8oBRpMHRp1p
	orRtcdwZciNNkNBKPOdlxWgyU38eeptoAVo0ZVrlJn1LyYft81YOwo38ZpkV+4yKQcmP/KiTFCq
	RdTawGgsznrHg==
X-Received: by 2002:a05:6a21:6110:b0:3d1:3c2:85b6 with SMTP id adf61e73a8af0-3da39b43743mr33286987637.5.1788763790919;
        Sun, 06 Sep 2026 23:49:50 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-338778fb926sm465210eec.31.2026.09.06.23.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:49:50 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 0/2] sched: fix typos and repeated words in comments
Date: Mon,  7 Sep 2026 12:19:41 +0530
Message-ID: <20260907064943.25304-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This corrects 2 misspellings and repeated words in comments.  Each is a
separate patch so that any one of them can be dropped without touching
the rest.

Nothing outside comments changes.  Every touched C file was checked by
dropping its comments, replacing each string literal with a placeholder
and collapsing whitespace; what remained was identical before and after,
so the compiled code cannot differ.

The mistakes were found with scripts/checkpatch.pl against the list in
scripts/spelling.txt.  The scanning, the edits and the changelogs were
produced with Cursor running the claude-opus-5 model, from a request to
find and fix spelling mistakes across the tree, and every correction was
then re-checked by the comparison described above.  Words that name an
identifier were left alone deliberately, even when they read as typos,
because correcting the prose would make the comment disagree with the
code it describes.

Tested by building x86_64 defconfig at v7.3-rc1-269-gbc35965f6940, which
is clean.  Nothing else was built, so any patch touching code that
x86_64 defconfig does not compile has been read but not compiled.

Hemanth Selam (2):
  sched: fix typo "upto" in comments
  tools/sched_ext: fix repeated word 'be' in comment

 kernel/sched/ext/ext.c                   | 4 ++--
 tools/sched_ext/include/scx/common.bpf.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.48.1

