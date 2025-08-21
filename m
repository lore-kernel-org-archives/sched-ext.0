Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C654310647;
	Thu, 21 Aug 2025 17:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797256; cv=none; b=I43VfCKuCRrEvFVejSzo6aiP+HAprhGa5BAqsneNro8A5QTgVa98bzntSdAurkPVyY410K4yyWAZTItUbW9MnTceyt2wQVAkFkBEqQSbwTmgJr4W4v6mCXcWX/i/Vyd7zmc3/vD01XyF8Dx8m2i2WHZ8vbFMiAhwlfcHAFcYfHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797256; c=relaxed/simple;
	bh=JsQO5twOE9+iKMjElHcje1BZeVUHNWoEP/wiiZWqJRU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EM3Au2Y7YkQ/cmUQacrsu54Wk5zl5zOOXi0PG4wBu1TI3MQUWg/552RO1IzOYeR715/5tTw6iNHCvkcd72up71hhpZvgfZ8YRKBfSvMQh0IbA0jESbr7in45pXI9Fv7fLSvP+9FYGtL22lb40GL1vASJ2Fsb9kZMuj36qHzzAss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qL8Dor1Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qL8Dor1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED5EC4CEEB;
	Thu, 21 Aug 2025 17:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755797256;
	bh=JsQO5twOE9+iKMjElHcje1BZeVUHNWoEP/wiiZWqJRU=;
	h=Date:From:To:Cc:Subject:From;
	b=qL8Dor1ZlElGyJGSd8fnG+TM+iMbwN1IPQo0bHq6i/1lZaBZfwBq4kdOeZwXsbjH8
	 FyBnupCs5T0TBDlzDADC1fKeJP2a4S+cFfDrAXx5q3YjsC5dB/xGXfnXdMMprgppOt
	 ASWvwi5afrpjipG6O+yD1+F9uMeDCEHBkHGGMfh1DaFsCOvgSOcUWZnkrWomE01upP
	 ZLwsI9DPWd2L4E5bWqkRYiHy48C4UwjQmNjTJZVGfWdUgVcvuTB/g3DNrga5Sk/nGo
	 D2HxhobKXWp1x/8OVbY8fReOTtSIzjOD5q3tduzjAgUSQSwsH2/P8aMtfP7CQWWcTB
	 Kzm/SJm91MuCA==
Date: Thu, 21 Aug 2025 07:27:35 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Subject: [GIT PULL] sched_ext: Fixes for v6.17-rc2
Message-ID: <aKdXB6r48hme9su1@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.17-rc2-fixes

for you to fetch changes up to e69980bd16f264581c3f606bae987e54f0ba8c4a:

  selftests/sched_ext: Remove duplicate sched.h header (2025-08-11 08:24:08 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v6.17-rc2

- Fix a subtle bug during SCX enabling where a dead task skips init but
  doesn't skip sched class switch leading to invalid task state transition
  warning.

- Cosmetic fix in selftests.

----------------------------------------------------------------
Andrea Righi (1):
      sched/ext: Fix invalid task state transitions on class switch

Jiapeng Chong (1):
      selftests/sched_ext: Remove duplicate sched.h header

 kernel/sched/ext.c                          | 4 ++++
 tools/testing/selftests/sched_ext/hotplug.c | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
tejun
