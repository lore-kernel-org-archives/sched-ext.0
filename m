Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F161430C36E;
	Mon, 22 Sep 2025 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557678; cv=none; b=DFG/Am7KGccEL/CJyN0vuDudWEDzxzx/07nuIJqeEkjMkBb4BdPZls6fk0iuPwtPZQtVtwLcVDgGV0uPwzPXyQINQW5c6rZHnFhOoTrNceYKWWCuh/Ew8H4IGys0OpTWwfJ9+JmaBxB8s3xlq55XHC1iisVVFImzZQ+mvHwj9QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557678; c=relaxed/simple;
	bh=SOLmbQP6bLxzMd4H3OlRuFgdkXbyM5XhDaq9Ts6XlvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hqYjISMv80l1VplWwSn46aVDGjDbIfK/Nx36NOzlJkEaT8GHRQLCEMUbdGH/45dRpSGYxy2yx454rNsuD4ajBpj9UJ5kVPZqpx5EYXIPpV6qbTUQwt+4X4r0b+aIQhrEXpVoaIz8c/0EKxlH9gyI4gf3Q+O/eLfAjbKFqnUfbek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYYqkLeK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYYqkLeK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A78C4CEF0;
	Mon, 22 Sep 2025 16:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758557677;
	bh=SOLmbQP6bLxzMd4H3OlRuFgdkXbyM5XhDaq9Ts6XlvE=;
	h=From:To:Cc:Subject:Date:From;
	b=RYYqkLeKBvmZrArFsF+8N2ZLWTRtGVdvyhK+LJR0ImKhRkBEfcGydvegw5VizQrg4
	 Eh+KikuQDg6p6vL2OjGnGdHlGwiCsjbA6iRk3P1VBGJLKc6LqfLaUYz6dKDwQhFILM
	 IMH6C+zHQuYsOsCxWeGO2SFaXwPhnXaJ+xJOQJ3J2TinrCqmWzOLXPx+BPyA9PORM4
	 IigMjOArhJCu4OadCG1KnijIkpg2BUbfv/17Hb3sBVhZ1iRJXMHvYSQ84nbjnjflOC
	 VKR+lBkmctEA5bIOA0di2GAlb9hSxFe4c7TFBZRXlEgo31ZeBkAh0hWejizKU0EB20
	 Zyz207qmLEU6Q==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCHSET sched_ext/scx-misc-a] sched_ext: Add @sch parameter in preparation for multi-sched support
Date: Mon, 22 Sep 2025 06:14:29 -1000
Message-ID: <20250922161436.358949-1-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset systematically adds the @sch parameter to various sched_ext
functions in preparation for multiple scheduler support. This part is
needed regardless of how the rest of the multiple scheduler patchset
develops. The changes also remove a bunch of naked scx_root dereferences
that trigger sparse warnings. The changes are mostly mechanical parameter
additions without functional changes.

The patches are based on sched_ext/for-6.18 (ac6772e8bcda) +
"sched_ext: misc cleanups and improvements"
(http://lkml.kernel.org/r/20250922013246.275031-1-tj@kernel.org).

 1 sched_ext: Separate out scx_kick_cpu() and add @sch to it
 2 sched_ext: Add the @sch parameter to __bstr_format()
 3 sched_ext: Add the @sch parameter to ext_idle helpers
 4 sched_ext: Drop kf_cpu_valid()
 5 sched_ext: Add the @sch parameter to scx_dsq_insert_preamble/commit()
 6 sched_ext: Drop scx_kf_exit() and scx_kf_error()
 7 sched_ext: Misc updates around scx_sched instance pointer

The following git tree also contains the patchset:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-sched-misc-prep

 kernel/sched/ext.c      | 355 ++++++++++++++++++++++++++++++------------------
 kernel/sched/ext_idle.c | 146 ++++++++++++++++----
 2 files changed, 340 insertions(+), 161 deletions(-)

--
tejun
