Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38141346AD5;
	Mon, 16 Mar 2026 05:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773639810; cv=none; b=N3WkC5cr/OXyPNIKelAU4hzAak1WgZI5COPwL4M3XN2lmUVRoID4wXyoRMrTAxGIhQ2Rram3BiSAmgX89w2a5LDj8OKF2YBPxMwSDclD2TRkdB14v8CzE5ku1EW3lG2k//Mq+6GaGYc1kIyNXFI8bFkEFig91spCvqeWycC/w8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773639810; c=relaxed/simple;
	bh=FIxUxc/ckc9wxxpaKP7AyhPwlzKzH7H0dYmCgWCx7+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sMDPFwnVWvJ4QwPjhTw9rpIWqkRy9BiaQCQfw4HUewSPW/Oayni/5sKSCYTA3XrTym/QvgO9kS8qssakZ0VB1OlPrAcVlP7UnUlbKfXbqpcofwHE2d8Jj5sk47bUdiSuaARs7PkcGBYjpMRzLfGBOQkE/JZLmvUgyPfAKwriBNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFlQfw8F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFlQfw8F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE59C19425;
	Mon, 16 Mar 2026 05:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773639809;
	bh=FIxUxc/ckc9wxxpaKP7AyhPwlzKzH7H0dYmCgWCx7+8=;
	h=From:To:Cc:Subject:Date:From;
	b=tFlQfw8FXsccNDLaAkxLJ52A1ag/mrw3H3m0M0wuls8uf4l7FhUVUNY0LN78BDlwF
	 X+qDgVpfRAmahmKiyd1MYVhrdiCkXShEfnJ0mJBtjYZlTYIr5M2iUA6I+FI+wndGu6
	 V015MpUDM9pZhLEDkRhE/KVrBPj4cj87no9+z3WDCHEOQd3VqbXC0ao8+E53FSc7rE
	 3klrQDS7EN/ybB5YpSgRYwJDI1dSw2Sz2pj5rW3vitsk2+iMS9qT3HYdTBPQlAYyuL
	 b8SlFPx1ub8C6IF/f8g3p34zMa/AgppgaSZ2Uc87qE/7TDISIitkipirQgfapnuCYN
	 AI4tEMTscWTAg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: David Carlier <devnexen@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.1] sched_ext: Fix kobject and cgroup ref error handling in scx_alloc_and_add_sched()
Date: Sun, 15 Mar 2026 19:43:26 -1000
Message-ID: <20260316054328.838304-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Fix error handling bugs in scx_alloc_and_add_sched():

 0001 sched_ext: Fix cgroup double-put on sub-sched abort path
 0002 sched_ext: Use kobject_put() for kobject_init_and_add() failure in scx_alloc_and_add_sched()

Based on sched_ext/for-7.1 (f96bc0fa92be).

 kernel/sched/ext.c | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

--
tejun
