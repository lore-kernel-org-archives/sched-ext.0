Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6F13B2D0F
	for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361168; cv=none; b=fP+4w6IShw52b3O3W38fQOdmicjF7ewT/LodUhlC45T2sdywLe1i/tonlO3CoJaQHtfGINlVJbt9p3XyjwlZSGy6A+y1B+If5LwU6QfDOoa9Q/NmPO8ylG1/pSKIw0wbIl39fK34hxm/6nmke1uzt9xdqYPywab8d/VYMnj/HMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361168; c=relaxed/simple;
	bh=E2w8DmAVaMW75AI1KKQq7NAxSvVCjQskOf6JueLXrZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u05YnflHrofC3vQBDHP8M9z96JzNxUQ/war3FU/B59xxi29h2c1YpsWr0/YwFtxE98AZM1DeZr4lSH8yUfhxY5aZs9DN3w6BcA4b7aR/4SIVIf0XMbQgRp8BmTolQItL83mPg0r/r7Xdh1w4n4UJT7rOERsk9VqZ3lDKsUrvoIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=iBaRcB9D; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="iBaRcB9D"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id AA06126FC6;
	Thu, 21 May 2026 12:59:23 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ckbdggIV6ZHA; Thu, 21 May 2026 12:59:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1779361163; bh=E2w8DmAVaMW75AI1KKQq7NAxSvVCjQskOf6JueLXrZc=;
	h=From:To:Cc:Subject:Date;
	b=iBaRcB9DuuLSy3WyDdijfwDOzYaz97UDhbH9EwpHADMco5D5RtHyuvPJjwYqmTewt
	 cfVd9RewZOkUEJTn0MqkjA/WXybLZgGivA3MOZrcBLxUoB4CiTCwdr+MD+aFMwLATF
	 22pVkshnLz93zke+OJx4Elt+XmyWLoTbPDl+bY2/u39IFvkkhkzm7dQE0IFGX0n+ln
	 IO9ykvPi4uwhm9UMtH/1bfG9R9BYsB7Dv0p1QblcAklp4lRZsNRn1pHjpB3PiCtoNU
	 cvI06fbagiPsTQ5S/XupjkxQoPD6NDvwO4hUQcfRd9wX1S2/k84S22FGeoweTgP+P/
	 mkfW+eoEoiAcA==
From: Samuele Mariotti <smariotti@disroot.org>
To: arighi@nvidia.com,
	tj@kernel.org,
	void@manifault.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Samuele Mariotti <smariotti@disroot.org>
Subject: [PATCH V2 0/1] sched_ext: Fix spurious WARN on stale ops_state in ops_dequeue()
Date: Thu, 21 May 2026 12:59:10 +0200
Message-ID: <20260521105911.1814606-1-smariotti@disroot.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

Note: scripts/checkpatch.pl reports a false positive for the word
"fallthrough" in a comment. The wording was intentionally kept as-is per
review discussion, as it accurately describes the control flow. 

Changes v1 -> v2:
- Use READ_ONCE() for p->scx.flags to ensure fresh reads
- Add cpu_relax() to reduce power consumption and improve performance
  during the spin-wait
- Use unlikely() to optimize branch prediction for the common case
- Expand comment to document the bounded retry guarantee

Thanks,
Samuele

Samuele Mariotti (1):
  sched_ext: Fix spurious WARN on stale ops_state in ops_dequeue()

 kernel/sched/ext.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

-- 
2.54.0

