Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B76377006
	for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 03:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776656490; cv=none; b=RASJVwRRgAhHl+jpSuW+XW3Ssr1XFFOjhUl410fJ1V6oD5I4z+IYlRKEryaVlc2KIQvxdsmp+qAKxgZtupC9UecPizGicZI6BtLqhj29ON3D+6vbNX1SXNGIydhX3fxoQEjX9qKz8nJAY4S6BGneDxMwxr7seWmb9nui1IAlSNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776656490; c=relaxed/simple;
	bh=pT14+sd5SYw0Z6LaUo2ShLHW9LSVVN8Ot/OlhxHIbZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ogJVliyVz8TdEwdawUnVunlyleZBm/sYg1B44XYkRO5t5EKDXapESXcoOiyUT3ZE6M+GKwHAaXQndP0p0yIRuoYSt9cYsM3+bAfO0jJfFEr9CJKU3JeE0M/AXfJO50g+/5NEQzUX1AoQg87bo14JP0atXF5fBJHbfv99t4kDJSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: n6d78p8GQwSU1eQhmbA0vw==
X-CSE-MsgGUID: c7OoR38uTAq0iR+kdtf2qw==
X-IronPort-AV: E=Sophos;i="6.23,189,1770566400"; 
   d="scan'208";a="173361169"
From: =?utf-8?B?6IuP5LmL6YGT?= <suzhidao@xiaomi.com>
To: zhidao su <soolaugust@gmail.com>
CC: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi
	<arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
	"sched-ext@lists.linux.dev" <sched-ext@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External Mail][PATCH] sched_ext: Honor SCX_OPS_ALWAYS_ENQ_IMMED
 on framework-internal goto-local paths
Thread-Topic: [External Mail][PATCH] sched_ext: Honor SCX_OPS_ALWAYS_ENQ_IMMED
 on framework-internal goto-local paths
Thread-Index: AQHc0HaYMX2WC1VmCEms/dFB3+nHrrXmyAQA
Date: Mon, 20 Apr 2026 03:41:21 +0000
Message-ID: <1773D394-3CD3-4E8C-BA38-42639B4BC087@xiaomi.com>
References: <20260420033329.1642822-1-suzhidao@xiaomi.com>
In-Reply-To: <20260420033329.1642822-1-suzhidao@xiaomi.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <53D581875A278444854C9DF5CD16C5D0@xiaomi.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

c29ycnkgZm9yIG5vaXNl77yMdGhlIG1lc3NhZ2UgaXMgd3JvbmcgYW5kIG5lZWQgcmVjYWxsLg0K
DQpCZXN0IHJlZ2FyZHMNCnpoaWRhbyBzdQ0KDQo+IDIwMjblubQ05pyIMjDml6UgMTE6MzPvvIx6
aGlkYW8gc3UgPHNvb2xhdWd1c3RAZ21haWwuY29tPiDlhpnpgZPvvJoNCj4NCj4gZW50aXJlbHkN
Cg0KIy8qKioqKirmnKzpgq7ku7blj4rlhbbpmYTku7blkKvmnInlsI/nsbPlhazlj7jnmoTkv53l
r4bkv6Hmga/vvIzku4XpmZDkuo7lj5HpgIHnu5nkuIrpnaLlnLDlnYDkuK3liJflh7rnmoTkuKrk
urrmiJbnvqTnu4TjgILnpoHmraLku7vkvZXlhbbku5bkurrku6Xku7vkvZXlvaLlvI/kvb/nlKjv
vIjljIXmi6zkvYbkuI3pmZDkuo7lhajpg6jmiJbpg6jliIblnLDms4TpnLLjgIHlpI3liLbjgIHm
iJbmlaPlj5HvvInmnKzpgq7ku7bkuK3nmoTkv6Hmga/jgILlpoLmnpzmgqjplJnmlLbkuobmnKzp
gq7ku7bvvIzor7fmgqjnq4vljbPnlLXor53miJbpgq7ku7bpgJrnn6Xlj5Hku7bkurrlubbliKDp
maTmnKzpgq7ku7bvvIEgVGhpcyBlLW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBjb250YWluIGNv
bmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIFhJQU9NSSwgd2hpY2ggaXMgaW50ZW5kZWQgb25s
eSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUu
IEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAo
aW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3Vy
ZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4g
dGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0
aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHBob25lIG9y
IGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgaXQhKioqKioqLyMNCg==
