Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22883E51E6;
	Tue,  3 Mar 2026 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772559603; cv=none; b=sUZg77cYqQYAdhnnGpweTpBZzCo6UJORlmGTUZoQfwpe+MXXYctu3Ftos4cBU3XfJBNJeKU29BBUkRMH+dSdF89otZIR+nbUHnGhRc9TRNP/3Nek/FVhUcZ9d5Hu5Tg/jIKtuVJnZeoMfdLrzdMIKy4bF/ZxrE0W5SsM9KnxW/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772559603; c=relaxed/simple;
	bh=RUYop4kT9bd8ygdhcd3AsQqY7sF7yhtwAkorCE7h8pU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=cf5G2FSx1YKuX6wvNNDk169Q+svoQAegtBFFygm9ra5hZvaxjnbcyMB9OopDAY6SOCLzDo/aCxG7f9GAvUwaS0N2zkrnZ057X6G/9mDLl6VovdYTZFBqU8WTFYXv3MLPtgRvmIxDfgxtQ29mzA/8oIQk5c8Iz1TnW3HIMmY92OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaB/uJw+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaB/uJw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A94C116C6;
	Tue,  3 Mar 2026 17:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772559603;
	bh=RUYop4kT9bd8ygdhcd3AsQqY7sF7yhtwAkorCE7h8pU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HaB/uJw+OKcM9guvVLTBF8czxI2lsYI0jlngj8i014SyWK6aIE6RjLiJD/EIu8tpP
	 wri6effJezA9Md1a0Bv/5wMIYr3SsrmnfpPdbfX7t9B++aIeAPjFAD78d9KGVRFAvh
	 m0TICZkZlaAnwpY+D/pFcpVriMlPS5TOzZ1egXslHnK1Zl+zsOQ7tB9qonjUo2w9Hd
	 vZJ8q1D/EQtcHrW+D4JzdRE9HSUwgyKNvPjL2p6hbZ6VjwNMHURbQMLZomgdbqQ6zA
	 1PrMl7ZDklRVVOuhy1Rt+G0aO/kVGE9Q6Pdm0owHD/kaiieKVprP/wZRYTusp70mQ+
	 kpk1xqJ7U6Cbw==
Date: Tue, 03 Mar 2026 07:40:02 -1000
Message-ID: <66725e9c501dd24db83a0a9b0c8d9f93@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com
Subject: Re: [PATCH 1/1] sched/ext: Remove redundant css_put()
In-Reply-To: <20260303143530.135968-2-yphbchou0911@gmail.com>
References: <20260303143530.135968-2-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.0-fixes with the following updates:

- Subject updated to "sched_ext: Remove redundant css_put() in
  scx_cgroup_init()"
- Added Fixes and Cc stable tags

Thanks.

--
tejun
