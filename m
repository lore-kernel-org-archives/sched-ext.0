Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB531DED63;
	Sat, 18 Jul 2026 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784369431; cv=none; b=AcKEkU92+x/iWTCO25zLQDv1722BgEBe8f8C7ys86fvCqH4q9i3vTku+rz3B4IiFVIrnJBKfTEN1iFxsffk+vN66dPMgz1cLXB4t+cxLVBZsFScv2kp3AU/eChHTLIqCcaL8n8cKyie2IburADxNarLY3zqeM+lKWIM9wZSLc/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784369431; c=relaxed/simple;
	bh=Y134Pjeq4AoDbpyFzxSuAM4eYA9zKmYzxm+hTfkErEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=or/L/urPou8GvPAyKbXg1ZdfqS9JTkcthB+qfvKMCUSrHBb8vDyrZDxXb10Gszrn1RmUKHas5845LunlFb9LX46s+QQdf1QtBmmxsp3RMCeF2JBaav8WtJpRvS/Z/ygJP2a9bY6GV/ffzDXq0/piwBRjKdM1/NyQiUr8JsBWHuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4yUTpJp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4yUTpJp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C821F000E9;
	Sat, 18 Jul 2026 10:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784369430;
	bh=zwkq7dzkHPupoKvHLeLidk5YYHR4DPu8V/wECfrYJzc=;
	h=From:To:Cc:Subject:Date;
	b=g4yUTpJpOS2xBG1UsxQWPh6tMoXX4AG7DvagpI/Yg0tvjj0mRuOW3LV7pIfgXtFkc
	 f6vWiPYj//dMQ7beEtWBMVz7cJo+coxQ3N5+GkfpVFvd24xSuEu2sd9lZ7MpLmFvr8
	 iEWqdtN8tR/up4qbKN7klOICAzyliG3aFJS3Mpwim4CZeRN5DQocS4yDqs+1nYhSyF
	 l39YctbtKb4FDA3e3sm0ZOFYG7P8F8AD2VeV/ErUTXEfvCqXgRCoX5Ux1IHhYlCv2u
	 EpoGTD5LGWaO8fCLPv+IynDJ4fVnXFTauTayx9IyOebIdbMKwHpE/piJ5MN8/ymJH9
	 DQYZHnx+VyJJA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.3] sched_ext: Rename the cid-form cgroup ops to cpuctl_*
Date: Sat, 18 Jul 2026 00:10:27 -1000
Message-ID: <20260718101029.725350-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Two unrelated things go by "cgroup" in the cid form. Sub-schedulers attach
to cgroups, and the cgroup_*() ops deliver cpu controller events. While the
ops names suggest cgroup2 hierarchy, they actually operate on the cpu
controller. The cid form has no users beyond scx_qmap yet, so rename the
ops to cpuctl_* while the ABI can still change. The cpu form is deployed
ABI and keeps the old names.

- 0001 factors the skeleton open path out of SCX_OPS_OPEN() and adds
  SCX_OPS_CID_OPEN() so that cid-form skeletons don't depend on the
  cpu-form member names dereferenced by the compat clears.

- 0002 renames the ops to cpuctl_* in struct sched_ext_ops_cid and updates
  scx_qmap, the only cid-form scheduler.

Based on sched_ext/for-7.3 (7c2cd767705d) plus the cgroup migration
patchset:

  https://lore.kernel.org/r/20260718081727.582037-1-tj@kernel.org

Tejun Heo (2):
  tools/sched_ext: Add SCX_OPS_CID_OPEN for cid-form schedulers
  sched_ext: Rename the cid-form cgroup ops to cpuctl_*

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-cpuctl-rename

 kernel/sched/ext/ext.c               | 36 ++++++++++++++++++------------------
 kernel/sched/ext/internal.h          | 25 ++++++++++++-------------
 tools/sched_ext/include/scx/compat.h | 30 ++++++++++++++++++++++--------
 tools/sched_ext/scx_qmap.bpf.c       | 22 +++++++++++-----------
 tools/sched_ext/scx_qmap.c           |  4 ++--
 tools/sched_ext/scx_qmap.h           |  2 +-
 6 files changed, 66 insertions(+), 53 deletions(-)

--
tejun
