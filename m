Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A773E3C4B;
	Mon,  4 May 2026 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921845; cv=none; b=kQYj/RCqhq8HJSP40XSUzh5myejLaWsd6ew3qd2rUUZZLRIsp20xTNK7RjX9M4/vVxq4nUNAcubSYEvHiFzrcf9859aeJa2gWcbFxlZ9D5FTqegSB3vE40u0i41mDbPyJm2brXohjj/reGN9J+esFj7vhmvZdm/tlkGLEFO3GEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921845; c=relaxed/simple;
	bh=t+ZVVMg/W9COGeEP63gp3j+xohr0L9p9H+M/EeyqRBI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=G8AHqx/N9hybvxBL88Jm2TARGs20SomZo4ZchQ4U6JA/xhhbRHTzlNC5MVgS3vuPmJtNqIL00rpkwf8j1vX2CCRvhJofY65sbHXdX7zc6oZf+/ZiqHutIwiJNY3Hoq2DFuAPQ8nbe9QjM7YYYmVQrDa7pAVsTh/fbraJYQn9joo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYk0EWzO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYk0EWzO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6892FC2BCB8;
	Mon,  4 May 2026 19:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777921845;
	bh=t+ZVVMg/W9COGeEP63gp3j+xohr0L9p9H+M/EeyqRBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TYk0EWzOeMWmzVfZd+ml+hECSw/Z0FpdqvBR1Se8oWaBPiaHfASLst4Y0pwAzoI7r
	 rR8kUn7t3Jn1O/YjiyDPif8Q46fwy5LknNayy3TVhQ06ruMuoaOe0f184ET71opao9
	 YJ5XNoKwx5CDpqCwBF7/5Z74F4rHzy0cDPma0gFc1rI55643f0hLuILW15ALlEMhhT
	 y8SzZOvM8mUDFpnLuTtkESf6SNF6MGijPNvjEFVvMfgMHNSOC+M5de66x6QP1Tb96X
	 utskm2Ynqyc46BDT4pDzln+IFPNV4aM6j/jZzpqSP4ZxBkuYH8we9owTp7BEmd8K1W
	 63a0QzOVW+wfA==
Date: Mon, 04 May 2026 09:10:44 -1000
Message-ID: <ea1756cb54d17e0ff19c4e21262e20ec@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.1-fixes] sched_ext: Fix cgroup iter coverage of in-do_exit tasks
In-Reply-To: <20260428001635.3293997-1-tj@kernel.org>
References: <20260428001635.3293997-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied 1-2 to sched_ext/for-7.1-fixes with the first patch's prefix
changed to "cgroup, sched_ext: " to reflect that it touches cgroup
core.

Thanks.

--
tejun
